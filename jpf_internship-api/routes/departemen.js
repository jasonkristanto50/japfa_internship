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

////////////////////////////////////////////////  ADD NEW /////////////////////////////////////////////////////////

router.post('/add-multiple-departemen', async (req, res) => {  
    const departments = req.body; // Expecting an array of departemen objects  

    // Validate that the body is an array  
    if (!Array.isArray(departments)) {  
        return res.status(400).json({ error: 'Body must be an array of departemen objects' });  
    }  

    try {  
        const values = departments.map(department => ({  
            id_departemen: department.id_departemen,  
            nama_departemen: department.nama_departemen,  
            deskripsi: department.deskripsi,  
            syarat_departemen: department.syarat_departemen,  
            path_image: department.path_image,  
            max_kuota: department.max_kuota,  
            jumlah_pengajuan: department.jumlah_pengajuan,  
            jumlah_approved: department.jumlah_approved,  
            jumlah_on_boarding: department.jumlah_on_boarding,  
            sisa_kuota: department.sisa_kuota  
        }));  

        // Define the columns explicitly  
        const columns = new pgp.helpers.ColumnSet([  
            'id_departemen',  
            'nama_departemen',  
            'deskripsi',  
            'syarat_departemen',  
            'path_image',  
            'max_kuota',  
            'jumlah_pengajuan',  
            'jumlah_approved',  
            'jumlah_on_boarding',  
            'sisa_kuota'  
        ], { table: 'departemen' });  

        const query = pgp.helpers.insert(values, columns);  

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


//////////////////////////////////////////// FETCH DATA ///////////////////////////////////////////////////////
// Get all Departemen
router.get('/fetch-all-departemen', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM DEPARTEMEN ORDER BY id_departemen ASC');
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching Departemen:', error.message, error.stack);
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

// Endpoint to fetch all departments and update data 
router.get('/fetch-all-departemen-data-updated', async (req, res) => {  
    try {  
        // Fetch all departments  
        const result = await pool.query(`SELECT * FROM DEPARTEMEN ORDER BY id_departemen ASC`);  

        if (result.rows.length === 0) {  
            return res.status(404).json({ message: 'No departments found' });  
        }  

        const departemenList = result.rows;  

        // Process each department to fetch and update counts  
        for (const department of departemenList) {  
            const namaDepartemen = department.nama_departemen;  

            // Fetch counts  
            const newJumlahPengajuan = await countPengajuan(namaDepartemen);  
            const newJumlahApproved = await countApproved(namaDepartemen); 
            const newJumlahOnBoarding = await countOnBoarding(namaDepartemen);
            const newSisaKuota = department.max_kuota - newJumlahApproved - newJumlahOnBoarding; 

            // Update counts in the DEPARTEMEN table  
            await pool.query(  
                'UPDATE DEPARTEMEN SET jumlah_pengajuan = $1, jumlah_approved = $2, jumlah_on_boarding = $3, sisa_kuota = $4 WHERE nama_departemen = $5',  
                [newJumlahPengajuan, newJumlahApproved, newJumlahOnBoarding, newSisaKuota, namaDepartemen]  
            );  

            // Update the department object with new values  
            department.jumlah_pengajuan = newJumlahPengajuan;  
            department.jumlah_approved = newJumlahApproved; 
            department.jumlah_on_boarding = newJumlahOnBoarding;
            department.sisa_kuota = newSisaKuota;
        }  

        res.status(200).json(departemenList); // Return the updated list of departments  
    } catch (error) {  
        console.error('Error fetching and updating departments:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  


// Fetch current jumlahPengajuan for a specific department  
router.get('/fetch-pengajuan-departemen/:departmentName', async (req, res) => {  
    const { departmentName } = req.params;  
  
    try {  
      const result = await pool.query(  
        `SELECT jumlah_pengajuan FROM DEPARTEMEN WHERE nama_departemen = $1`,  
        [departmentName]  
      );  
  
      // Check if any department was found  
      if (result.rowCount === 0) {  
        return res.status(404).json({ error: 'Department not found' });  
      }  
  
      const currentJumlahPengajuan = result.rows[0].jumlah_pengajuan;  
  
      res.status(200).json({  
        message: 'Current jumlah pengajuan fetched successfully!',  
        data: {  
          total_count: currentJumlahPengajuan,  
        },  
      });  
    } catch (error) {  
      console.error('Error fetching jumlah pengajuan:', error);  
      res.status(500).json({ error: 'Server error' });  
    }  
  });  


////////////////////////////////////////////// UPDATE DATA ///////////////////////////////////////////////

// Update max_kuota and calculate sisa_kuota  
router.put('/update-max-kuota/:id', async (req, res) => {  
    const { id } = req.params;  
    const { max_kuota } = req.body;  

    try {  
        // Get current jumlah_approved  
        const jumlahApprovedResult = await pool.query(  
            'SELECT jumlah_approved FROM DEPARTEMEN WHERE id_departemen = $1',  
            [id]  
        );  

        if (jumlahApprovedResult.rowCount === 0) {  
            return res.status(404).json({ error: 'Departemen not found' });  
        }  

        const jumlahApproved = jumlahApprovedResult.rows[0].jumlah_approved;  
        const newSisaKuota = max_kuota - jumlahApproved;  

        // Now update max_kuota and sisa_kuota  
        const result = await pool.query(  
            'UPDATE DEPARTEMEN SET max_kuota = $1, sisa_kuota = $2 WHERE id_departemen = $3 RETURNING *',  
            [max_kuota, newSisaKuota, id]  
        );  

        res.status(200).json({ message: 'Max kuota and sisa kuota updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating max_kuota:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Update deskripsi and syarat  
router.put('/update-deskripsi-syarat/:departmentName', async (req, res) => {  
    const { departmentName } = req.params;  
    const { deskripsi, syarat_departemen } = req.body;  

    try {  
        // Check if department exists  
        const departmentCheckResult = await pool.query(  
            'SELECT nama_departemen, deskripsi, syarat_departemen FROM DEPARTEMEN WHERE nama_departemen = $1',  
            [departmentName]  
        );  

        if (departmentCheckResult.rowCount === 0) {  
            return res.status(404).json({ error: 'Departemen not found' });  
        }  

        // Update deskripsi and syarat  
        const result = await pool.query(  
            'UPDATE DEPARTEMEN SET deskripsi = $1, syarat_departemen = $2 WHERE nama_departemen = $3 RETURNING *',  
            [deskripsi, syarat_departemen, departmentName]  
        );  

        res.status(200).json({ message: 'Deskripsi and syarat updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating deskripsi and syarat:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  


////////////////////////////////////////////// DELETE DATA ///////////////////////////////////////////////////////

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




///////////////////////////////////////////// FUNCTION //////////////////////////////////////////////////////////
// Function to count jumlah_pengajuan  
async function countPengajuan(departmentName) {  
    const result = await pool.query(  
        `SELECT COUNT(*) AS total_count FROM PESERTA_MAGANG WHERE departemen = $1 AND status_magang = 'On Process'`,   
        [departmentName]  
    );  
    return parseInt(result.rows[0].total_count);  
}  

// Function to count jumlah_approved  
async function countApproved(departmentName) {  
    const result = await pool.query(  
        `SELECT COUNT(*) AS total_approved FROM PESERTA_MAGANG WHERE departemen = $1 AND status_magang = 'Diterima'`,   
        [departmentName]  
    );  
    return parseInt(result.rows[0].total_approved);  
}

// Function to count jumlah_on_boarding
async function countOnBoarding(departmentName) {  
    const result = await pool.query(  
        `SELECT COUNT(*) AS total_on_boarding FROM PESERTA_MAGANG WHERE departemen = $1 AND status_magang = 'Sedang Berlangsung'`,   
        [departmentName]  
    );  
    return parseInt(result.rows[0].total_on_boarding);  
} 

module.exports = router;
