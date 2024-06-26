require('dotenv').config();

const admin = require('firebase-admin');

const Server = require('./models/server');

const serviceAccount = require('./config/serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Crear instancia del servidor y escuchar en el puerto
const server = new Server();
server.listen();