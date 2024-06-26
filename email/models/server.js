require('dotenv').config();
const express = require('express');
const cors = require('cors');

class Server {
    constructor() {
        this.app = express();
        this.port = process.env.PORT || 8003;

        this.middlewares();
        this.routes();
    };

    routes() {
        this.app.use('/api', require('../routes/email'));
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
