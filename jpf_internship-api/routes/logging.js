const express = require('express');
const router = express.Router();
const { Pool } = require('pg'); 
require('dotenv').config();  

// Create a new instance of Pool for database queries  
const pool = new Pool({  
    user: process.env.DB_USER,  
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,  
    password: process.env.DB_PASSWORD,  
    port: process.env.DB_PORT || 5432,  
});  

// Create a new log entry
router.post('/add-log', async (req, res) => {
    const { loguser, logtable, logkey, logkeyvalue, logtype, logdetail } = req.body;

    const query = `
        INSERT INTO LOGGING (loguser, logtable, logkey, logkeyvalue, logtype, logdetail)
        VALUES ($1, $2, $3, $4, $5, $6)
    `;

    try {
        await pool.query(query, [loguser, logtable, logkey, logkeyvalue, logtype, logdetail]);
        res.status(201).json({ message: 'Log entry created successfully.' });
    } catch (error) {
        console.error('Error creating log entry:', error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
});


// Route to fetch all logging data
router.get('/fetch-log', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM LOGGING ORDER BY logdate DESC');

        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching logs:', error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router;