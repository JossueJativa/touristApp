require('dotenv').config();
const nodemailer = require("nodemailer");
const { Router } = require('express');

const router = Router();

router.post('/send-email', (req, res) => {
    const { email, subject, message } = req.body;

    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.APPLICATION_EMAIL,
            pass: process.env.APPLICATION_PASSWORD,
        },
        tls: {
            rejectUnauthorized: false
        }
    });

    const mailOptions = {
        from: process.env.APPLICATION_EMAIL,
        to: email,
        subject: subject,
        text: message,
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error(error);
            return res.status(500).json({
                message: 'Internal server error',
            });
        }
        console.log('Email sent: ' + info.response);
        res.json({
            message: 'Email sent successfully',
        });
    });
});

module.exports = router;
