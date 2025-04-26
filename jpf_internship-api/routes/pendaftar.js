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

// Endpoint: Create a new user in the pendaftar table  
router.post('/add', async (req, res) => {  
    const { id_pelamar, nama, no_telp, email, asal_universitas, password, role} = req.body;  

    try {  
        console.log('Received data:', req.body);  
        await pool.query(  
            'INSERT INTO pendaftar (id_pelamar, nama, no_telp, email, asal_universitas, password, role) VALUES ($1, $2, $3, $4, $5, $6, $7)',  
            [id_pelamar, nama, no_telp, email, asal_universitas, password, role]  
        );  
        res.status(201).json({ message: 'User created successfully!' });  
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

// Endpoint: Fetch the count of users in the pendaftar table  
router.get('/count', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT COUNT(*) AS count FROM pendaftar');  
        const count = parseInt(result.rows[0].count, 10); // Ensure the count is returned as an integer  
        res.json({ count });  
    } catch (error) {  
        console.error('Error fetching user count:', error);  
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });  
    }  
});  

// Endpoint: Fetch all users in the pendaftar table  
router.get('/fetch-all-pendaftar', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM pendaftar');  
        res.status(200).json(result.rows); // Return the rows as JSON  
    } catch (error) {  
        console.error('Error fetching users:', error);  
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });  
    }  
});  

// Endpoint: Delete all users in the pendaftar table  
router.delete('/delete-all-pendaftar', async (req, res) => {  
    try {  
        const result = await pool.query('DELETE FROM pendaftar');  
        res.status(200).json({ message: 'All users have been deleted successfully!' });  
    } catch (error) {  
        console.error('Error deleting users:', error);  
        res.status(500).json({ error: 'Failed to delete data', details: error.message });  
    }  
});  

module.exports = router;  