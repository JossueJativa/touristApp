const { Router } = require('express');
const { savePhone, getPhone, getAllPhones } = require('../database/phoneDB')

const router = Router();

router.post('/save', async(req, res) => {
    const { user_id, code_phone } = req.body;
    await savePhone(user_id, code_phone);

    res.json({
        message: 'Phone saved'
    });
});

router.get('/get/:user_id', async(req, res) => {
    const { user_id } = req.params;
    const phone = await getPhone(user_id);

    res.json(phone);
});

router.get('/get', async(req, res) => {
    const phones = await getAllPhones();

    res.json(phones);
});

module.exports = router;