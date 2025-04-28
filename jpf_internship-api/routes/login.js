const express = require('express');  
const router = express.Router();  
const { Pool } = require('pg');  
require('dotenv').config();  

const pool = new Pool({  
    user: process.env.DB_USER,  
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,  
    password: process.env.DB_PASSWORD,  
    port: process.env.DB_PORT || 5432,  
});  

// Unified login endpoint  
router.post('/', async (req, res) => {  
    const { email, password } = req.body;  

    try {  
        // Check in ADMIN table  
        let result = await pool.query(  
            'SELECT * FROM ADMIN WHERE email = $1 AND password = $2',  
            [email, password]  
        );  

        if (result.rows.length > 0) {  
            const admin = result.rows[0];  
            return res.status(200).json({  
                role: admin.role // Return role for admin  
            });  
        }  

        // Check in pendaftar table  
        result = await pool.query(  
            'SELECT * FROM pendaftar WHERE email = $1 AND password = $2',  
            [email, password]  
        );  

        if (result.rows.length > 0) {  
            const user = result.rows[0];  
            return res.status(200).json({  
                role: user.role // Return role for pendaftar  
            });  
        }  

        // If no user found  
        return res.status(401).json({ error: 'Invalid credentials' });  
    } catch (error) {  
        console.error('Login error:', error);  
        return res.status(500).json({ error: 'Server error' });  
    }  
});  

module.exports = router;  