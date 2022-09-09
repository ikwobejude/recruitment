const model = require("../model/applicant")



module.exports.adminSendEmailNotificationGet = async(req, res) => {
    let ministies = await model.organization.findAll();
    res.render('./admin/admin_send_email', {
        title: "Emailing", 
        ministies
    })
}

module.exports.adminSendEmailNotificationPos = async(req, res) => {

}