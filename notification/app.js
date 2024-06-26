require('dotenv').config();

const express = require('express');
const { initializeApp, applicationDefault  } = require('firebase-admin/app');

process.env.GOOGLE_APPLICATION_CREDENTIALS;

initializeApp({
  credential: applicationDefault(),
});

// Crear instancia del servidor y escuchar en el puerto
const app = express();
app.use(express.json());

app.use('/api', require('./routes/notification'));

const PORT = process.env.PORT || 8001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
