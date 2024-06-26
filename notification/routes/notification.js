const { Router } = require('express');
const admin = require('firebase-admin');
const { savePhone, getPhone, getAllPhones } = require('../database/phoneDB');
const { getMessaging } = require('firebase-admin/messaging');

const router = Router();

router.post('/save', async (req, res) => {
    const { user_id, code_phone } = req.body;
    await savePhone(user_id, code_phone);

    res.status(201).json({
        message: 'Phone saved'
    });
});

router.get('/get/:user_id', async (req, res) => {
    const { user_id } = req.params;
    const phone = await getPhone(user_id);

    res.status(200).json(phone);
});

router.get('/get', async (req, res) => {
    const phones = await getAllPhones();

    res.status(200).json(phones);
});

router.post('/send-notification', async (req, res) => {
    const { user_id, title, message, fcmtoken } = req.body;

    try {
        const userPhoneInfo = await getPhone(user_id);

        if (!userPhoneInfo || !userPhoneInfo.code_phone) {
            return res.status(404).json({ error: 'Device token not found for user' });
        }

        const userToken = userPhoneInfo.code_phone;

        const messageData = {
            notification: {
                title,
                body: message
            },
            token: userToken
        }

        getMessaging().send(messageData)
            .then((response) => {
                console.log('Successfully sent message:', response);
                res.status(200).json({ success: true, message: 'Notification sent successfully' });
            })
            .catch((error) => {
                console.error('Error sending message:', error);
                res.status(500).json({ success: false, error: 'Failed to send notification' });
            });
            
    } catch (error) {
        console.error('Error sending notification:', error);
        res.status(500).json({ success: false, error: 'Failed to send notification' });
    }
});

module.exports = router;