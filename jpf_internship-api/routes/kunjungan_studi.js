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

// Add a new Kunjungan Studi  
router.post('/submit-kunjungan-studi', async (req, res) => {  
    const { id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, jumlah_anak, tanggal_kegiatan, status } = req.body;  

    try {   
        await pool.query(  
            'INSERT INTO KUNJUNGAN_STUDI (id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, jumlah_anak, tanggal_kegiatan, status) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)',  
            [id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, jumlah_anak, tanggal_kegiatan, status]  
        );  
        res.status(201).json({ message: 'Kunjungan Studi added successfully!' });  
    } catch (error) {  
        console.error('Error adding Kunjungan Studi:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get all Kunjungan Studi  
router.get('/fetch-all-kunjungan-data', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM KUNJUNGAN_STUDI');  
        res.status(200).json(result.rows);  
    } catch (error) {  
        console.error('Error fetching Kunjungan Studi:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get count of Kunjungan Studi  
router.get('/count', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT COUNT(*) AS count FROM KUNJUNGAN_STUDI');  
        res.status(200).json({ count: result.rows[0].count });  
    } catch (error) {  
        console.error('Error fetching count:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
}); 


// Update status of Kunjungan Studi
router.put('/:id', async (req, res) => {
    const { id } = req.params;  // ID of the Kunjungan Studi to update
    const { status } = req.body;  // New status ("Diterima" or "Ditolak")
  
    try {
      const result = await pool.query(
        'UPDATE KUNJUNGAN_STUDI SET status = $1 WHERE id_kunjungan_studi = $2 RETURNING *',
        [status, id]
      );
  
      if (result.rowCount === 0) {
        return res.status(404).json({ error: 'Kunjungan Studi not found' });
      }
  
      res.status(200).json({ message: 'Status updated successfully!', data: result.rows[0] });
    } catch (error) {
      console.error('Error updating Kunjungan Studi status:', error);
      res.status(500).json({ error: 'Server error' });
    }
  });
  

// Delete all Kunjungan Studi records
router.delete('/delete-all-kunjungan-data', async (req, res) => {
    try {
      const result = await pool.query('DELETE FROM KUNJUNGAN_STUDI');
      res.status(200).json({
        message: `Successfully deleted ${result.rowCount} records from KUNJUNGAN_STUDI.`,
      });
    } catch (error) {
      console.error('Error deleting all Kunjungan Studi records:', error);
      res.status(500).json({ error: 'Server error' });
    }
  });
  

// Delete a Kunjungan Studi by ID  
router.delete('/delete-kunjungan-by-id', async (req, res) => {  
    const { id_kunjungan_studi } = req.params;  

    try {  
        const result = await pool.query('DELETE FROM KUNJUNGAN_STUDI WHERE id_kunjungan_studi = $1', [id_kunjungan_studi]);  
        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Kunjungan Studi not found' });  
        }  
        res.status(200).json({ message: 'Kunjungan Studi deleted successfully!' });  
    } catch (error) {  
        console.error('Error deleting Kunjungan Studi:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

module.exports = router;  