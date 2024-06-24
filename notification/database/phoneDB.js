const fs = require('fs');
const path = require('path');

const phoneDB = path.join(__dirname, 'phoneDB.json');

const dbConnection = async() => {
    try {
        if(!fs.existsSync(phoneDB)) {
            fs.writeFileSync(phoneDB, JSON.stringify([]));
        }
    } catch (error) {
        console.error(error);
    }
}

const savePhone = async(user_id, code_phone) => {
    try {
        const phones = JSON.parse(fs.readFileSync(phoneDB, 'utf-8'));
        const newPhone = {
            user_id,
            code_phone
        };
        phones.push(newPhone);

        fs.writeFileSync(phoneDB, JSON.stringify(phones));
    } catch (error) {
        console.error(error);
    }
}

const getPhone = async(user_id) => {
    try {
        const phones = JSON.parse(fs.readFileSync(phoneDB, 'utf-8'));
        const phone = phones.find(phone => phone.user_id === user_id);

        return phone;
    } catch (error) {
        console.error(error);
    }
}

const getAllPhones = async() => {
    try {
        const phones = JSON.parse(fs.readFileSync(phoneDB, 'utf-8'));
        const phonesWithoutUser = phones.filter(phone => !phone.user_id);

        return phonesWithoutUser;
    } catch (error) {
        console.error(error);
    }
}

module.exports = {
    dbConnection,
    savePhone,
    getPhone,
    getAllPhones
}