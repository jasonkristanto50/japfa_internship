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
        path_foto_diri,  
        status_magang, 
        password_token, 
        nilai_akhir_magang,  
    } = req.body;  

    try {  
        await pool.query(  
            'INSERT INTO PESERTA_MAGANG (id_magang, nama, departemen, alamat, no_telp, email, asal_universitas, angkatan, nilai_univ, jurusan, path_cv, path_persetujuan_univ, path_transkrip_nilai, path_foto_diri, status_magang, password_token, nilai_akhir_magang) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)',  
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
                path_foto_diri,  
                status_magang,  
                password_token,
                nilai_akhir_magang,  
            ]  
        );  
        res.status(201).json({ message: 'Peserta Magang added successfully!' });  
    } catch (error) {  
        console.error('Error adding Peserta Magang:', error.message);  ;  
        res.status(500).json({ error: 'Server error', error });  
    }  
});  
////////////////////////////////////////////////// FETCH DATA ///////////////////////////////////////////////////////

// Get all Peserta Magang  
router.get('/fetch-all-peserta-data', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM PESERTA_MAGANG ORDER BY id_magang ASC');  
        res.status(200).json(result.rows);  
    } catch (error) {  
        console.error('Error fetching Peserta Magang:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get Peserta Magang data by email
router.get('/fetch-peserta-data/:email', async (req, res) => { 
    const{email} = req.params
    try {  
        const result = await pool.query('SELECT * FROM PESERTA_MAGANG WHERE email = $1', [email] );  
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

// Count jumlah_pengajuan based on peserta magang for specific department  
router.get('/count-pengajuan-for-department/:departmentName', async (req, res) => {  
    const { departmentName } = req.params;  

    try {  
        // Query to count the number of applicants for the specific department  
        const result = await pool.query(  
            `SELECT COUNT(*) AS total_count  
             FROM PESERTA_MAGANG  
             WHERE departemen = $1`,  
            [departmentName]
        );  

        const totalCount = parseInt(result.rows[0].total_count);  

        // Update jumlah_pengajuan in the DEPARTEMEN table  
        await pool.query(  
            'UPDATE DEPARTEMEN SET jumlah_pengajuan = $1 WHERE nama_departemen = $2',  
            [totalCount, departmentName]  
        );  

        res.status(200).json({  
            message: 'Jumlah pengajuan counted and updated successfully!',  
            data: {  
                total_count: totalCount,  
            },  
        });  
    } catch (error) {  
        console.error('Error counting pengajuan for department:', error.message);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Count jumlahApproved based on peserta magang for specific department  
router.get('/count-approved-for-department/:departmentName', async (req, res) => {  
    const { departmentName } = req.params;  

    try {  
        // Query to count the number of approved applicants for the specific department  
        const result = await pool.query(  
            `SELECT COUNT(*) AS total_approved  
             FROM PESERTA_MAGANG  
             WHERE nama_departemen = $1 AND status_magang = 'Diterima'`,  
            [departmentName]  
        );  

        const totalApproved = parseInt(result.rows[0].total_approved);  

        // Update jumlah_approved in the DEPARTEMEN table  
        await pool.query(  
            'UPDATE DEPARTEMEN SET jumlah_approved = $1 WHERE nama_departemen = $2',  
            [totalApproved, departmentName]  
        );  

        res.status(200).json({  
            message: 'Jumlah approved counted and updated successfully!',  
            data: {  
                total_approved: totalApproved,  
            },  
        });  
    } catch (error) {  
        console.error('Error counting approved for department:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Get Peserta Magang data by nama pembimbing
router.get('/fetch-data-by-pembimbing/:namaPembimbing', async (req, res) => {
    const { namaPembimbing } = req.params;

    try {
        const result = await pool.query('SELECT * FROM PESERTA_MAGANG WHERE nama_pembimbing = $1', [namaPembimbing]);
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Error fetching data by pembimbing:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Get Pembimbing data by email
router.get('/fetch-pembimbing-by-email/:email', async (req, res) => { 
    const { email } = req.params;

    try {  
        const result = await pool.query('SELECT nama_pembimbing FROM PESERTA_MAGANG WHERE email = $1', [email]);  
        if (result.rows.length > 0) {
            res.status(200).json(result.rows[0]);
        } else {
            res.status(404).json({ message: 'Pembimbing not found' });
        }  
    } catch (error) {  
        console.error('Error fetching pembimbing:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
}); 


///////////////////////////////////////////// UPDATE DATA ////////////////////////////////////////////////////////


// Update Peserta Magang by ID  
router.put('/update-data/:id', async (req, res) => {  
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

// Update Peserta Magang STATUS by Email  
router.put('/update-password-token/:email', async (req, res) => {  
    const { email } = req.params;
    const { password_token } = req.body;

    try {  
        const result = await pool.query(  
            'UPDATE PESERTA_MAGANG SET password_token = $1 WHERE email = $2 RETURNING *',  
            [  
                password_token,  
                email,  
            ]  
        );  

        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Peserta Magang not found' });  
        }  

        res.status(200).json({ message: 'Peserta Magang password token updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating Peserta Magang password token:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

// Update Peserta Magang STATUS by ID  
router.put('/update-status/:id', async (req, res) => {  
    const { id } = req.params;  // ID of the Peserta Magang to update  
    const { status_magang } = req.body;  // New status value  

    try {  
        const result = await pool.query(  
            'UPDATE PESERTA_MAGANG SET status_magang = $1 WHERE id_magang = $2 RETURNING *',  
            [  
                status_magang,  
                id,  
            ]  
        );  

        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Peserta Magang not found' });  
        }  

        res.status(200).json({ message: 'Peserta Magang status updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating Peserta Magang status:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});  

 // Update Peserta Magang LINK WAWANCARA by ID
router.put('/update-link-meet/:id', async (req, res) => {
    const { id } = req.params;  // ID of the Peserta Magang to update  
    const { tanggal_interview, jam_interview, link_meet_interview } = req.body;

    try {
        const result = await pool.query(
            `UPDATE PESERTA_MAGANG 
             SET tanggal_interview = $1, 
                 jam_interview = $2, 
                 link_meet_interview = $3 
             WHERE id_magang = $4 
             RETURNING *`,
            [
                tanggal_interview,  
                jam_interview,      
                link_meet_interview,
                id                  
            ]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Peserta Magang not found' });
        }

        res.status(200).json({ message: 'Peserta Magang details updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating Peserta Magang details:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update Catatan Hasil Wawancara by ID
router.post('/update-catatan-hasil-interview/:id', async (req, res) => {
    const { id } = req.params;  // ID of the Peserta Magang to update  
    const { catatan_hasil_interview } = req.body; // Extract catatan from the request body
    
    try {
        const result = await pool.query(
            `UPDATE PESERTA_MAGANG 
             SET catatan_hasil_interview = $1 
             WHERE id_magang = $2 
             RETURNING *`,
            [
                catatan_hasil_interview,
                id                         
            ]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Peserta Magang not found' });
        }

        res.status(200).json({ message: 'Catatan hasil wawancara updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating catatan hasil wawancara:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update path_laporan_akhir by email
router.put('/update-path-laporan-akhir-email/:email', async (req, res) => {
    const { email } = req.params; // Email of the Peserta Magang to update
    const { path_laporan_akhir } = req.body; // New path value

    try {
        const result = await pool.query(
            'UPDATE PESERTA_MAGANG SET path_laporan_akhir = $1 WHERE email = $2 RETURNING *',
            [path_laporan_akhir, email]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Peserta Magang not found' });
        }

        res.status(200).json({ message: 'path updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating path_laporan_akhir:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

// Update status and optional catatan_hr of Peserta Magang
router.put('/update_status-catatan/:id', async (req, res) => {
    const { id } = req.params; 
    const { status_magang, catatan_hr } = req.body;
  
    try {
        // Prepare the query based on the presence of catatan_hr
        const query = 
          'UPDATE PESERTA_MAGANG SET status_magang = $1, catatan_hr = $2 WHERE id_magang = $3 RETURNING *'
        ;
  
        // Prepare parameters for the query
        const params =[status_magang, catatan_hr, id];
  
        const result = await pool.query(query, params);
  
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Peserta Magang not found' });
        }
  
        res.status(200).json({ message: 'Status updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating Peserta Magang status:', error);
        res.status(500).json({ error: 'Server error' });
    }
  });

// Update nama_pembimbing for Peserta Magang by ID  
router.put('/update-nama-pembimbing/:id', async (req, res) => {  
    const { id } = req.params;
    const { nama_pembimbing } = req.body;

    try {  
        const result = await pool.query(
            'UPDATE PESERTA_MAGANG SET nama_pembimbing = $1 WHERE id_magang = $2 RETURNING *',
            [nama_pembimbing, id]
        );

        if (result.rowCount === 0) {  
            return res.status(404).json({ error: 'Peserta Magang not found' });  
        }

        res.status(200).json({ message: 'Nama pembimbing updated successfully!', data: result.rows[0] });  
    } catch (error) {  
        console.error('Error updating nama pembimbing:', error);  
        res.status(500).json({ error: 'Server error' });  
    }  
});

// Update validasi_laporan_akhir by ID
router.put('/validasi-laporan-akhir/:id', async (req, res) => {
    const { id } = req.params;
    const { validasi_laporan_akhir } = req.body;

    try {
        const result = await pool.query(
            'UPDATE PESERTA_MAGANG SET validasi_laporan_akhir = $1 WHERE id_magang = $2 RETURNING *',
            [validasi_laporan_akhir, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Peserta Magang not found' });
        }

        res.status(200).json({ message: 'Validasi laporan akhir updated successfully!', data: result.rows[0] });
    } catch (error) {
        console.error('Error updating validasi laporan akhir:', error);
        res.status(500).json({ error: 'Server error' });
    }
});

/////////////////////////////////////////////// DELETE //////////////////////////////////////////////

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