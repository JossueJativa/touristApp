require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { dbConnection } = require('../database/phoneDB');
const { initializeApp, applicationDefault } = require('firebase-admin/app');

// Inicializa Firebase Admin
initializeApp({
    credential: applicationDefault(),
});

class Server {
    constructor() {
        this.app = express();
        this.port = process.env.PORT || 8001;

        this.connectDB();

        this.middlewares();
        this.routes();
    };

    async connectDB() {
        await dbConnection();
    }

    routes() {
        this.app.use('/api', require('../routes/notification'));
    };

    middlewares() {
        this.app.use(cors());
        this.app.use(express.json());
    };

    listen() {
        this.app.listen(this.port, () => {
            console.log(`Server running on port ${this.port}`);
        });
    };
}

module.exports = Server;
