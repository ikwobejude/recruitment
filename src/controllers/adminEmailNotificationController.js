const model = require("../model/applicant")
const { Sequelize, QueryTypes } = require('sequelize');
const Op = Sequelize.Op;
const db = require('../db/db');
const { completpaymentEmail } = require("../config/email_service");


module.exports.adminSendEmailNotificationGet = async (req, res) => {
    let ministies = await model.organization.findAll();
    res.render('./admin/admin_send_email', {
        title: "Emailing",
        ministies
    })
}

module.exports.adminSendEmailNotificationPos = async (req, res) => {
    try {
        console.log(req.body)
        // if (req.body.emailtype == "APPLICANT") {
        //     if (req.body.current_step == '7') {
                let sql = `
                SELECT 
                    new_applications.applicant_fullname, 
                    new_applications.process_number, 
                    new_applications.email, 
                    assessments.invoice_number,
                    organization.name AS org_name,
                    organization.code AS code,
                    job_category.name AS job
                FROM new_applications
                INNER JOIN organization ON new_applications.org_id = organization.code
                INNER JOIN job_category ON new_applications.job_position = job_category.code
                INNER JOIN assessments ON new_applications.process_number = assessments.assessment_rule
                WHERE
                assessments.settlement_status = 0 AND new_applications.current_step =${req.body.current_step} limit 2 `;
                let applicantNew = await  db.query(sql, { type: QueryTypes.SELECT });
                console.log(applicantNew)
                applicantNew.forEach(n => {
                    completpaymentEmail(n)
                });
                res.status(200).json({ msg: "done" })
        //     }
        // }

    } catch (error) {
        console.log(error)
        res.status(201).json({ err: error.message })
    }
}