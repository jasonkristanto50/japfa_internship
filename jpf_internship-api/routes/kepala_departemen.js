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

// Endpoint: Create a new kepala departemen
router.post('/add-new-kepala-departemen', async (req, res) => {
    const { id_kepala_departemen, nama, email, departemen, password, role, status } = req.body;

    try {
        console.log('Received data:', req.body);
        await pool.query(
            'INSERT INTO KEPALA_DEPARTEMEN (id_kepala_departemen, nama, email, departemen, password, role, status) VALUES ($1, $2, $3, $4, $5, $6, $7)',
            [id_kepala_departemen, nama, email, departemen, password, role, status]
        );
        res.status(201).json({ message: 'Kepala Departemen created successfully!' });
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

// Endpoint: Fetch the count of kepala departemen
router.get('/count-jumlah-kepala-departemen', async (req, res) => {
    try {
        const result = await pool.query('SELECT COUNT(*) AS count FROM KEPALA_DEPARTEMEN');
        const count = parseInt(result.rows[0].count, 10); // Ensure the count is returned as an integer
        res.json({ count });
    } catch (error) {
        console.error('Error fetching kepala departemen count:', error);
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });
    }
});

// Endpoint: Fetch all kepala departemen
router.get('/fetch-all-kepala-departemen', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM KEPALA_DEPARTEMEN');
        res.status(200).json(result.rows); // Return the rows as JSON
    } catch (error) {
        console.error('Error fetching kepala departemen:', error);
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });
    }
});

// Endpoint: Delete all kepala departemen
router.delete('/delete-all-kepala-departemen', async (req, res) => {
    try {
        await pool.query('DELETE FROM KEPALA_DEPARTEMEN');
        res.status(200).json({ message: 'All kepala departemen have been deleted successfully!' });
    } catch (error) {
        console.error('Error deleting kepala departemen:', error);
        res.status(500).json({ error: 'Failed to delete data', details: error.message });
    }
});

// Endpoint: Update a kepala departemen's department
router.put('/update-departemen/:id', async (req, res) => {
    const { id } = req.params; // ID of kepala departemen
    const { departemen } = req.body; // New department value

    try {
        const result = await pool.query(
            'UPDATE KEPALA_DEPARTEMEN SET departemen = $1 WHERE id_kepala_departemen = $2 RETURNING *',
            [departemen, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Kepala Departemen not found' });
        }

        res.status(200).json({ message: 'Department updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating departemen:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Endpoint: Update kepala departemen status
router.put('/update-status/:id', async (req, res) => {
    const { id } = req.params; // ID of kepala departemen
    const { status } = req.body; // New status value

    try {
        const result = await pool.query(
            'UPDATE KEPALA_DEPARTEMEN SET status = $1 WHERE id_kepala_departemen = $2 RETURNING *',
            [status, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Kepala Departemen not found' });
        }

        res.status(200).json({ message: 'Status updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating status:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router;