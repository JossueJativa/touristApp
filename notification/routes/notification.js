const { Router } = require('express');
const admin = require('firebase-admin');
const { savePhone, getPhone, getAllPhones } = require('../database/phoneDB');

const router = Router();

router.post('/save', async (req, res) => {
    const { user_id, code_phone } = req.body;
    await savePhone(user_id, code_phone);

    res.json({
        message: 'Phone saved'
    }, 201);
});


router.get('/get/:user_id', async (req, res) => {
    const { user_id } = req.params;
    const phone = await getPhone(user_id);

    res.json(phone, 200);
});

router.get('/get', async (req, res) => {
    const phones = await getAllPhones();

    res.json(phones, 200);
});

router.post('/send-notification', async (req, res) => {
    const { user_id, title, message } = req.body;

    try {
        const userPhoneInfo = await getPhone(user_id);

        if (!userPhoneInfo || !userPhoneInfo.code_phone) {
            return res.status(404).json({ error: 'Device token not found for user' });
        }

        const userToken = userPhoneInfo.code_phone;

        // Crear el payload de la notificación
        const payload = {
            notification: {
                title: title,
                body: message,
            },
        };

        // Enviar la notificación utilizando Firebase Admin SDK
        const response = await admin.messaging().sendToDevice(userToken, payload);

        console.log('Notification sent successfully:', response);
        res.json({ success: true, message: 'Notification sent successfully' });
    } catch (error) {
        console.error('Error sending notification:', error);
        res.status(500).json({ success: false, error: 'Failed to send notification' });
    }
});

module.exports = router;
