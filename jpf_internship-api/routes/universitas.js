const express = require('express');
const router = express.Router();
const { Pool } = require('pg');
const pgp = require('pg-promise')();
require('dotenv').config();

const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT || 5432,
});

//////////////////////////////////////////// FETCH DATA ///////////////////////////////////////////////////////
// Get all Universitas
router.get('/fetch-all-universitas', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM UNIVERSITAS ORDER BY akreditasi ASC');
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching Universitas:', error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router;