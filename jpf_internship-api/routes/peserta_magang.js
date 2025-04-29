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

// Add a new Peserta Magang  
router.post('/submit-peserta-magang', async (req, res) => {  
    const {  
        id_magang,  
        nama,  
        departemen,  
        alamat,  
        no_telp,  
        email,  
        asal_universitas,  
        angkatan,  
        nilai_univ,  
        jurusan,  
        path_cv,  
        path_persetujuan_univ,  
        path_transkrip_nilai,  
        status_magang,  
        nilai_akhir_magang,  
    } = req.body;  

    try {  
        await pool.query(  
            'INSERT INTO PESERTA_MAGANG (id_magang, nama, departemen, alamat, no_telp, email, asal_universitas, angkatan, nilai_univ, jurusan, path_cv, path_persetujuan_univ, path_transkrip_nilai, status_magang, nilai_akhir_magang) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)',  
            [  
                id_magang,  
                nama,  
                departemen,  
                alamat,  
                no_telp,  
                email,  
                asal_universitas,  
                angkatan,  
                nilai_univ,  
                jurusan,  
                path_cv,  
                path_persetujuan_univ,  
                path_transkrip_nilai,  
                status_magang,  
                nilai_akhir_magang,  
            ]  
        );  
        res.status(201).json({ message: 'Peserta Magang added successfully!' });  
    } catch (error) {  
        console.error('Error adding Peserta Magang:', error.message);  ;  
        res.status(500).json({ error: 'Server error', error });  
    }  
});  

// Get all Peserta Magang  
router.get('/fetch-all-peserta-data', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM PESERTA_MAGANG');  
        res.status(200).json(result.rows);  
    } catch (error) {  
        console.error('Error fetching Peserta Magang:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get count of Peserta Magang  
router.get('/count', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT COUNT(*) AS count FROM PESERTA_MAGANG');  
        res.status(200).json({ count: parseInt(result.rows[0].count) });  
    } catch (error) {  
        console.error('Error fetching count:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Update Peserta Magang by ID  
router.put('/:id', async (req, res) => {  
    const { id } = req.params;  // ID of the Peserta Magang to update  
    const {  
        nama,  
        departemen,  
        alamat,  
        no_telp,  
        email,  
        asal_universitas,  
        angkatan,  
        nilai_univ,  
        jurusan,  
        path_cv,  
        path_persetujuan_univ,  
        path_transkrip_nilai,  
        status_magang,  
        nilai_akhir_magang,  
    } = req.body;  

    try {  
        const result = await pool.query(  
            'UPDATE PESERTA_MAGANG SET nama = $1, departemen = $2, alamat = $3, no_telp = $4, email = $5, asal_universitas = $6, angkatan = $7, nilai_univ = $8, jurusan = $9, path_cv = $10, path_persetujuan_univ = $11, path_transkrip_nilai = $12, status_magang = $13, nilai_akhir_magang = $14 WHERE id_magang = $15 RETURNING *',  
            [  
                nama,  
                departemen,  
                alamat,  
                no_telp,  
                email,  
                asal_universitas,  
                angkatan,  
                nilai_univ,  
                jurusan,  
                path_cv,  
                path_persetujuan_univ,  
                path_transkrip_nilai,  
                status_magang,  
                nilai_akhir_magang,  
                id,  
            ]  
        );  

        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Peserta Magang not found' });  
        }  

        res.status(200).json({ message: 'Peserta Magang updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating Peserta Magang:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Delete all Peserta Magang records  
router.delete('/delete-all-peserta-data', async (req, res) => {  
    try {  
        const result = await pool.query('DELETE FROM PESERTA_MAGANG');  
        res.status(200).json({  
            message: `Successfully deleted ${result.rowCount} records from PESERTA_MAGANG.`,  
        });  
    } catch (error) {  
        console.error('Error deleting all Peserta Magang records:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Delete a Peserta Magang by ID  
router.delete('/delete-peserta-by-id/:id', async (req, res) => {  
    const { id } = req.params;  // ID to delete  

    try {  
        const result = await pool.query('DELETE FROM PESERTA_MAGANG WHERE id_magang = $1', [id]);  
        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Peserta Magang not found' });  
        }  
        res.status(200).json({ message: 'Peserta Magang deleted successfully!' });  
    } catch (error) {  
        console.error('Error deleting Peserta Magang:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

module.exports = router;  