// To start : cd jpf_internship-api 
// npm start

const express = require('express');  
const { Pool } = require('pg');  
const cors = require('cors');  
const bodyParser = require('body-parser');  
const multer = require('multer'); // Import multer  
const path = require('path'); // Import path module  
require('dotenv').config(); // For environment variables

// Import fuzzy
const fuzzyLogic = require('./fuzzy_logic/fuzzy_logic');

const app = express();  
const port = process.env.PORT || 3000 || 8080;  

// Middleware  
app.use(cors());  
app.use(bodyParser.json());  

// Serve static files from the 'uploads' directory
app.use('/api/jpf_internship-api/uploads', express.static(path.join(__dirname, 'uploads')));

// PostgreSQL connection pool  
const pool = new Pool({  
    user: process.env.DB_USER,          
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,   
    password: process.env.DB_PASSWORD,   
    port: process.env.DB_PORT || 5432,    
});  

pool.connect()
    .then(() => console.log('Connected to PostgreSQL'))
    .catch(err => console.error('Connection error', err.stack));

// Add a simple root route -- for server hosting
app.get('/', (req, res) => {
    res.send('Welcome to the JPF Internship API!');
});

// // Start the server  
// app.listen(port, '0.0.0.0', () => {  
//     console.log(`Server running at http://0.0.0.0:${port}`);  
// });  

// Start server in localhost  
app.listen(port, 'localhost', () => {  
    console.log(`Server running at http://localhost:${port}`);  
});  

// Routes  
const pendaftarRouter = require('./routes/pendaftar');  
app.use('/api/pendaftar', pendaftarRouter);  

const adminRouter = require('./routes/admin');  
app.use('/api/admin', adminRouter);  

const kunjunganStudiRouter = require('./routes/kunjungan_studi');  
app.use('/api/kunjungan_studi', kunjunganStudiRouter);

const pesertaMagangRouter = require('./routes/peserta_magang');  
app.use('/api/peserta_magang', pesertaMagangRouter);

const departemenRouter = require('./routes/departemen');  
app.use('/api/departemen', departemenRouter);

const kepalaDepartemenRouter = require('./routes/kepala_departemen');
app.use('/api/kepala_departemen', kepalaDepartemenRouter);

const loginRouter = require('./routes/login');  
app.use('/api/login', loginRouter);

const file_uploadRouter = require('./routes/file_upload');  
app.use('/api/file_upload', file_uploadRouter);

const emailRouter = require('./routes/email');
app.use('/api/email', emailRouter);

const logbookRouter = require('./routes/logbook');
app.use('/api/logbook', logbookRouter);

const skillPesertaRouter = require('./routes/skill_peserta');
app.use('/api/skill_peserta', skillPesertaRouter);
