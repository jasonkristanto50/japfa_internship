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
  const { id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, jumlah_peserta, tanggal_kegiatan, jam_kegiatan, path_persetujuan_instansi, status, password_token } = req.body;  

  // Validate required fields
  if (!id_kunjungan_studi || !nama_perwakilan || !no_telp || !email || !asal_universitas || !jumlah_peserta || !tanggal_kegiatan || !jam_kegiatan || !path_persetujuan_instansi || !status) {
      return res.status(400).json({ error: 'All fields are required' });
  }

  try {   
      await pool.query(  
          'INSERT INTO KUNJUNGAN_STUDI (id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, jumlah_peserta, tanggal_kegiatan, jam_kegiatan, path_persetujuan_instansi, status, password_token) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)',  
          [id_kunjungan_studi, nama_perwakilan, no_telp, email, asal_universitas, parseInt(jumlah_peserta), tanggal_kegiatan, jam_kegiatan, path_persetujuan_instansi, status, password_token]
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
        const result = await pool.query('SELECT * FROM KUNJUNGAN_STUDI ORDER BY tanggal_kegiatan ASC');  
        res.status(200).json(result.rows);  
    } catch (error) {  
        console.error('Error fetching Kunjungan Studi:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get Peserta Magang data by ID
router.get('/fetch-kunjungan-data/:email', async (req, res) => { 
    const{email} = req.params
    try {  
        const result = await pool.query('SELECT * FROM KUNJUNGAN_STUDI WHERE email = $1', [email] );  
        res.status(200).json(result.rows);  
    } catch (error) {  
        console.error('Error fetching Peserta Magang:', error);  
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


// Update status and optional catatan_hr of Kunjungan Studi
router.put('/update_status-catatan/:id', async (req, res) => {
  const { id } = req.params; 
  const { status, catatan_hr } = req.body;  // New status and optional catatan

  try {
      // Prepare the query based on the presence of catatan_hr
      const query = `
        UPDATE KUNJUNGAN_STUDI 
        SET status = $1, catatan_hr = $2 
        WHERE id_kunjungan_studi = $3 RETURNING *
      `;

      // Prepare parameters for the query
      const params =[status, catatan_hr, id];

      const result = await pool.query(query, params);

      if (result.rowCount === 0) {
          return res.status(404).json({ error: 'Kunjungan Studi not found' });
      }

      res.status(200).json({ message: 'Status updated successfully!', data: result.rows[0] });
  } catch (error) {
      console.error('Error updating Kunjungan Studi status:', error);
      res.status(500).json({ error: 'Server error' });
  }
});

// Update status and optional catatan_hr of Kunjungan Studi
router.put('/update_status/:id', async (req, res) => {
    const { id } = req.params; 
    const { status} = req.body;  // New status and optional catatan
  
    try {
        // Prepare the query based on the presence of catatan_hr
        const query = `
          UPDATE KUNJUNGAN_STUDI 
          SET status = $1 
          WHERE id_kunjungan_studi = $2 RETURNING *
        `;
  
        // Prepare parameters for the query
        const params =[status, id];
  
        const result = await pool.query(query, params);
  
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Kunjungan Studi not found' });
        }
  
        res.status(200).json({ message: 'Status updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating Kunjungan Studi status:', error);
        res.status(500).json({ error: 'Server error' });
    }
  });

// Update only the path_file_respon_japfa of Kunjungan Studi
router.put('/update_path_file_respon_japfa/:id', async (req, res) => {
    const { id } = req.params; 
    const { path_file_respon_japfa } = req.body; // New field for the file path

    try {
        // Prepare the query to update only the path_file_respon_japfa
        const query = `
          UPDATE KUNJUNGAN_STUDI 
          SET 
            path_file_respon_japfa = $1
          WHERE id_kunjungan_studi = $2 
          RETURNING *
        `;

        // Prepare parameters for the query
        const params = [path_file_respon_japfa, id];
  
        const result = await pool.query(query, params);
  
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Kunjungan Studi not found' });
        }
  
        res.status(200).json({ message: 'Path file response updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating path_file_respon_japfa:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update tanggal_kegiatan and return updated fields
router.put('/update-tanggal/:id', async (req, res) => {
    const { id } = req.params; 
    const { tanggal_kegiatan } = req.body; // New tanggal_kegiatan

    try {
        // Prepare the SQL query to update tanggal_kegiatan
        const query = `
          UPDATE KUNJUNGAN_STUDI 
          SET tanggal_kegiatan = $1
          WHERE id_kunjungan_studi = $2 RETURNING tanggal_kegiatan, jam_kegiatan, email
        `;

        // Execute the query with parameters
        const params = [tanggal_kegiatan, id];
        const result = await pool.query(query, params);

        // Check if the record was found and updated
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Kunjungan Studi not found' });
        }

        // Return the updated fields in the response
        res.status(200).json({ 
            message: 'Tanggal updated successfully!', 
            updated_data: result.rows[0] 
        });
    } catch (error) {
        console.error('Error updating tanggal_kegiatan:', error);
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