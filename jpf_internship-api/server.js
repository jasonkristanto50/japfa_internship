// To start : cd jpf_internship-api 
// npm start

const express = require('express');  
const { Pool } = require('pg');  
const cors = require('cors');  
const bodyParser = require('body-parser');  
require('dotenv').config(); // For environment variables  

const app = express();  
const port = process.env.PORT || 3000;  

// Middleware  
app.use(cors());  
app.use(bodyParser.json());  

// PostgreSQL connection pool  
const pool = new Pool({  
    user: process.env.DB_USER,          // Using environment variables  
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,   // Set the database name in your .env file  
    password: process.env.DB_PASSWORD,   // Your database password  
    port: process.env.DB_PORT || 5432,    // Default PostgreSQL port  
});  

// Start the server  
app.listen(port, () => {  
    console.log(`Server running at http://localhost:${port}`);  
});  

// Routes  
const pendaftarRouter = require('./routes/pendaftar');  
app.use('/api/pendaftar', pendaftarRouter);  

const adminRouter = require('./routes/admin');  
app.use('/api/admin', adminRouter);  

const loginRouter = require('./routes/login');  
app.use('/api/login', loginRouter);

const kunjunganStudiRouter = require('./routes/kunjungan_studi');  
app.use('/api/kunjungan_studi', kunjunganStudiRouter);

const pesertaMagangRouter = require('./routes/peserta_magang');  
app.use('/api/peserta_magang', pesertaMagangRouter);

const departemenRouter = require('./routes/departemen');  
app.use('/api/departemen', departemenRouter);