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

// Add multiple Departemen
router.post('/add-multiple-departemen', async (req, res) => {
    const departments = req.body; // Expecting an array of departemen objects

    // Validate that the body is an array
    if (!Array.isArray(departments)) {
        return res.status(400).json({ error: 'Body must be an array of departemen objects' });
    }

    try {
        const values = departments.map(department => [
            department.id_departemen,
            department.nama_departemen,
            department.deskripsi,
            department.syarat_departemen,
            department.path_image,
            department.max_kuota,
            department.jumlah_pengajuan,
            department.jumlah_approved,
            department.jumlah_on_boarding,
            department.sisa_kuota
        ]);

        const queryText = `
            INSERT INTO DEPARTEMEN 
            (id_departemen, nama_departemen, deskripsi, syarat_departemen, path_image, 
            max_kuota, jumlah_pengajuan, jumlah_approved, jumlah_on_boarding, sisa_kuota)
            VALUES %L
        `;

        // Using pg-promise or any other query builder that supports multi-row inserts
        const query = format(queryText, values);
        
        // Insert the departments into the database
        await pool.query(query);

        res.status(201).json({ message: `${departments.length} Departemen(s) added successfully!` });
    } catch (error) {
        console.error('Error adding multiple Departemen:', error.message);
        res.status(500).json({ error: 'Server error' });
    }
});


// Add a new Departemen
router.post('/add-new-departemen', async (req, res) => {
    const {
        id_departemen,
        nama_departemen,
        deskripsi,
        syarat_departemen,
        path_image,
        max_kuota,
        jumlah_pengajuan,
        jumlah_approved,
        jumlah_on_boarding,
        sisa_kuota
    } = req.body;

    try {
        await pool.query(
            'INSERT INTO DEPARTEMEN (id_departemen, nama_departemen, deskripsi, syarat_departemen, path_image, max_kuota, jumlah_pengajuan, jumlah_approved, jumlah_on_boarding, sisa_kuota) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
            [id_departemen, nama_departemen, deskripsi, syarat_departemen, path_image, max_kuota, jumlah_pengajuan, jumlah_approved, jumlah_on_boarding, sisa_kuota]
        );
        res.status(201).json({ message: 'Departemen added successfully!' });
    } catch (error) {
        console.error('Error adding Departemen:', error.message);
        res.status(500).json({ error: 'Server error' });
    }
});


// Get all Departemen
router.get('/fetch-all-departemen', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM DEPARTEMEN');
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching Departemen:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Get count of Departemen
router.get('/count', async (req, res) => {
    try {
        const result = await pool.query('SELECT COUNT(*) AS count FROM DEPARTEMEN');
        res.status(200).json({ count: result.rows[0].count });
    } catch (error) {
        console.error('Error fetching count:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update max_kuota of Departemen
router.put('/update-max-kuota/:id', async (req, res) => {
    const { id } = req.params;
    const { max_kuota } = req.body;

    try {
        const result = await pool.query(
            'UPDATE DEPARTEMEN SET max_kuota = $1 WHERE id_departemen = $2 RETURNING *',
            [max_kuota, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }

        res.status(200).json({ message: 'max_kuota updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating max_kuota:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update jumlah_pengajuan of Departemen
router.put('/update-jumlah-pengajuan/:id', async (req, res) => {
    const { id } = req.params;
    const { jumlah_pengajuan } = req.body;

    try {
        const result = await pool.query(
            'UPDATE DEPARTEMEN SET jumlah_pengajuan = $1 WHERE id_departemen = $2 RETURNING *',
            [jumlah_pengajuan, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }

        res.status(200).json({ message: 'jumlah_pengajuan updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating jumlah_pengajuan:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update jumlah_approved of Departemen
router.put('/update-jumlah-approved/:id', async (req, res) => {
    const { id } = req.params;
    const { jumlah_approved } = req.body;

    try {
        const result = await pool.query(
            'UPDATE DEPARTEMEN SET jumlah_approved = $1 WHERE id_departemen = $2 RETURNING *',
            [jumlah_approved, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }

        res.status(200).json({ message: 'jumlah_approved updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating jumlah_approved:', error);
        res.status(500).json({ error: 'Server error' });
    }
});


// Update jumlah_on_boarding of Departemen
router.put('/update-jumlah-on-boarding/:id', async (req, res) => {
    const { id } = req.params;
    const { jumlah_on_boarding } = req.body;

    try {
        const result = await pool.query(
            'UPDATE DEPARTEMEN SET jumlah_on_boarding = $1 WHERE id_departemen = $2 RETURNING *',
            [jumlah_on_boarding, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }

        res.status(200).json({ message: 'jumlah_on_boarding updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating jumlah_on_boarding:', error);
        res.status(500).json({ error: 'Server error' });
    }
});


// Update sisa_kuota of Departemen
router.put('/update-sisa-kuota/:id', async (req, res) => {
    const { id } = req.params;
    const { sisa_kuota } = req.body;

    try {
        const result = await pool.query(
            'UPDATE DEPARTEMEN SET sisa_kuota = $1 WHERE id_departemen = $2 RETURNING *',
            [sisa_kuota, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }

        res.status(200).json({ message: 'sisa_kuota updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating sisa_kuota:', error);
        res.status(500).json({ error: 'Server error' });
    }
});



// Delete all Departemen records
router.delete('/delete-all-departemen', async (req, res) => {
    try {
        const result = await pool.query('DELETE FROM DEPARTEMEN');
        res.status(200).json({
            message: `Successfully deleted ${result.rowCount} records from DEPARTEMEN.`,
        });
    } catch (error) {
        console.error('Error deleting all Departemen records:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Delete a Departemen by ID
router.delete('/delete-departemen-by-id/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const result = await pool.query('DELETE FROM DEPARTEMEN WHERE id_departemen = $1', [id]);
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Departemen not found' });
        }
        res.status(200).json({ message: 'Departemen deleted successfully!' });
    } catch (error) {
        console.error('Error deleting Departemen:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router;
