const nodemailer = require('nodemailer');
const {user, password} = require("../ressources/configMail.json");

const transporter = nodemailer.createTransport({
    service : "gmail",
        auth: {
            user: user,
            pass: password
        },
    secure: true,
});

module.exports = transporter;