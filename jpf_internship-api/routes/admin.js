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

// Endpoint: Create a new admin  
router.post('/add-new-admin', async (req, res) => {  
    const { id_admin, nama, no_telp, email, departemen, password, role } = req.body;  

    try {  
        console.log('Received data:', req.body);  
        await pool.query(  
            'INSERT INTO ADMIN (id_admin, nama, no_telp, email, departemen, password, role) VALUES ($1, $2, $3, $4, $5, $6, $7)',  
            [id_admin, nama, no_telp, email, departemen, password, role]  
        );  
        res.status(201).json({ message: 'Admin created successfully!' });  
    } catch (err) {  
        console.error('Error during database operation:', {  
            message: err.message,  
            code: err.code,  
            detail: err.detail,  
            stack: err.stack  
        });  
        res.status(500).json({ error: 'Server error', details: err.message });  
    }  
});  

// Endpoint: Fetch the count of admins  
router.get('/count-jumlah-admin', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT COUNT(*) AS count FROM ADMIN');  
        const count = parseInt(result.rows[0].count, 10); // Ensure the count is returned as an integer  
        res.json({ count });  
    } catch (error) {  
        console.error('Error fetching admin count:', error);  
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });  
    }  
});  

// Endpoint: Fetch all admins  
router.get('/fetch-all-admin-data', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM ADMIN');  
        res.status(200).json(result.rows); // Return the rows as JSON  
    } catch (error) {  
        console.error('Error fetching admins:', error);  
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });  
    }  
});  

// Endpoint: Delete all admins  
router.delete('/delete-all', async (req, res) => {  
    try {  
        await pool.query('DELETE FROM ADMIN');  
        res.status(200).json({ message: 'All admins have been deleted successfully!' });  
    } catch (error) {  
        console.error('Error deleting admins:', error);  
        res.status(500).json({ error: 'Failed to delete data', details: error.message });  
    }  
});  

module.exports = router;  