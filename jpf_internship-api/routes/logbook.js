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

// Endpoint: Create a new logbook
router.post('/add-logbook', async (req, res) => {
    const { id_logbook, nama_peserta, nama_aktivitas, tanggal_aktivitas, email, departemen, url_lampiran } = req.body;

    try {
        console.log('Received data:', req.body);
        await pool.query(
            'INSERT INTO LOGBOOK_PESERTA_MAGANG (id_logbook, nama_peserta, nama_aktivitas, tanggal_aktivitas, email, departemen, url_lampiran) VALUES ($1, $2, $3, $4, $5, $6, $7)',
            [id_logbook, nama_peserta, nama_aktivitas, tanggal_aktivitas, email, departemen, url_lampiran]
        );
        res.status(201).json({ message: 'Logbook created successfully!' });
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

// Endpoint: Update aktivitas & tanggal by id
router.put('/update-logbook/:id', async (req, res) => {
    const { id } = req.params;
    const { nama_aktivitas, tanggal } = req.body;

    try {
        await pool.query(
            'UPDATE LOGBOOK_PESERTA_MAGANG SET nama_aktivitas = $1, tanggal = $2 WHERE id_logbook = $3',
            [nama_aktivitas, tanggal, id]
        );
        res.json({ message: 'Logbook updated successfully!' });
    } catch (err) {
        console.error('Error updating logbook:', err);
        res.status(500).json({ error: 'Failed to update logbook', details: err.message });
    }
});

// Endpoint: Update validasi by id
router.patch('/validasi-logbook/:id', async (req, res) => {
    const { id } = req.params;
    const { validasi } = req.body;

    try {
        await pool.query(
            'UPDATE LOGBOOK_PESERTA_MAGANG SET validasi = $1 WHERE id_logbook = $2',
            [validasi, id]
        );
        res.json({ message: 'Validasi updated successfully!' });
    } catch (err) {
        console.error('Error updating validasi:', err);
        res.status(500).json({ error: 'Failed to update validasi', details: err.message });
    }
});

// Endpoint: Delete logbook by id
router.delete('/delete-logbook/:id', async (req, res) => {
    const { id } = req.params;

    try {
        await pool.query('DELETE FROM LOGBOOK_PESERTA_MAGANG WHERE id_logbook = $1', [id]);
        res.json({ message: 'Logbook deleted successfully!' });
    } catch (err) {
        console.error('Error deleting logbook:', err);
        res.status(500).json({ error: 'Failed to delete logbook', details: err.message });
    }
});

// Endpoint: Fetch all logbook
router.get('/fetch-all', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM LOGBOOK_PESERTA_MAGANG');
        res.status(200).json(result.rows); // Return all rows as JSON
    } catch (error) {
        console.error('Error fetching all logbook:', error);
        res.status(500).json({ error: 'Failed to fetch all logbook', details: error.message });
    }
});

// Endpoint: Fetch logbook by email
router.get('/fetch-by-email/:email', async (req, res) => {
    const { email } = req.params;

    try {
        const result = await pool.query('SELECT * FROM LOGBOOK_PESERTA_MAGANG WHERE email = $1', [email]);
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching logbook:', error);
        res.status(500).json({ error: 'Failed to fetch logbook', details: error.message });
    }
});

module.exports = router;