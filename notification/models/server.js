const express = require('express');
const cors = require('cors');
const { dbConnection } = require('../database/phoneDB');

class Server {
    constructor() {
        this.app = express();
        this.port = process.env.PORT;

        this.connectDB();

        this.middlewares();
        this.routes();
    };

    async connectDB() {
        await dbConnection();
    }

    routes() {
        this.app.use('/api/notification', require('../routes/notification'));
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