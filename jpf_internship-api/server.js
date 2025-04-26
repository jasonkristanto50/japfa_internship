const express = require('express');  
const { Pool } = require('pg');  
const cors = require('cors');  
const bodyParser = require('body-parser');  

const app = express();  
const port = 3000;  

// Middleware  
app.use(cors());  
app.use(bodyParser.json());  

// PostgreSQL connection pool  
const pool = new Pool({  
    user: 'postgres',          // Replace with your PostgreSQL username  
    host: 'localhost',  
    database: 'jpf_internship_DB', // Replace with your database name  
    password: 'admin',       // Replace with your password  
    port: 5432,  
});  

// Start the server  
app.listen(port, () => {  
    console.log(`Server running at http://localhost:${port}`);  
});  


