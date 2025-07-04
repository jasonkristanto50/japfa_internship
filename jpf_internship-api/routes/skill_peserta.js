const express = require('express');  
const router = express.Router();  
const { Pool } = require('pg');  
require('dotenv').config();
const fuzzyLogic = require('../fuzzy_logic/fuzzy_logic');

// Create a new instance of Pool for database queries  
const pool = new Pool({  
    user: process.env.DB_USER,  
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,  
    password: process.env.DB_PASSWORD,  
    port: process.env.DB_PORT || 5432,  
});

// Fuzzy Logic
router.post('/fuzzy-scale', async (req, res) => {
    const { 
        total_softskill, 
        banyak_proyek, 
        nilai_univ,
        akreditasi_universitas,
        jurusan,
    } = req.body;

    try {
        // Fuzzy evaluations
        const fsSoftSkills = fuzzyLogic.fuzzyScale(total_softskill, 'softskills');
        const fsProjects = fuzzyLogic.fuzzyScale(banyak_proyek, 'projects');
        const fsIPK = fuzzyLogic.fuzzyScale(nilai_univ, 'ipk');
        const fsUniversitas = fuzzyLogic.fuzzyScale(akreditasi_universitas, 'universitas');
        const fsJurusan = fuzzyLogic.fuzzyScale(jurusan, 'jurusan'); 

        // Scores and weights
        const scores = {
            softskills: fsSoftSkills,
            projects: fsProjects,
            ipk: fsIPK,
            universitas: fsUniversitas,
            jurusan: fsJurusan,

        };

        const weights = {
            softskills: 0.46,
            projects: 0.27,
            ipk: 0.14,
            asalUniversitas: 0.05,
            jurusan: 0.05,
        };

        // Calculate overall fuzziness score
        const overallScore = fuzzyLogic.calculateOverallScore(scores, weights);

        res.status(201).json({ 
            message: 'Fuzzy scores calculated successfully!',
            scores: {
                softskills: fsSoftSkills,
                projects: fsProjects,
                ipk: fsIPK,
                universitas: fsUniversitas,
                jurusan: fsJurusan,
            },
            overallScore: overallScore
        });
    } catch (error) {
        console.error('Error:', error.message);
        res.status(500).json({ error: 'Calculation error', details: error.message });
    }
});

// Endpoint: Add new skill
router.post('/add-skill', async (req, res) => {  
    const { 
        id_skill, 
        nama_peserta, 
        departemen, 
        email, 
        asal_universitas,
        akreditasi_universitas,
        jurusan,
        nilai_univ,
        komunikasi, 
        kreativitas, 
        tanggung_jawab, 
        kerja_sama, 
        skill_teknis, 
        total_softskill,
        banyak_proyek, 
        list_proyek, 
        url_lampiran,
        fuzzy_score
    } = req.body;  

    try {  
        console.log('Received data:', req.body);  
        await pool.query(  
            'INSERT INTO SKILL_PESERTA_MAGANG (id_skill, nama_peserta, departemen, email, asal_universitas, akreditasi_universitas, jurusan, nilai_univ, komunikasi, kreativitas, tanggung_jawab, kerja_sama, skill_teknis, total_softskill, banyak_proyek, list_proyek, url_lampiran, fuzzy_score) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18)',  
            [ 
                id_skill, 
                nama_peserta, 
                departemen, 
                email, 
                asal_universitas,
                akreditasi_universitas,
                jurusan,
                nilai_univ,
                komunikasi, 
                kreativitas, 
                tanggung_jawab, 
                kerja_sama, 
                skill_teknis, 
                total_softskill,
                banyak_proyek, 
                list_proyek, 
                url_lampiran,
                fuzzy_score
            ]  
        );  
        res.status(201).json({ message: 'Skill added successfully!' });  
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

// Endpoint: Fetch all skills
router.get('/fetch-all-skills', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM SKILL_PESERTA_MAGANG');
        res.status(200).json(result.rows); // Return the rows as JSON
    } catch (error) {
        console.error('Error fetching skills:', error);
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });
    }
});  

// Endpoint: Fetch skill data by email
router.get('/fetch-skill-by-email/:email', async (req, res) => {
    const { email } = req.params;  
    try {
        const result = await pool.query('SELECT * FROM SKILL_PESERTA_MAGANG WHERE email = $1', [email]);
        if (result.rows.length > 0) {
            res.status(200).json(result.rows[0]); // Return the first skill entry found
        } else {
            res.status(404).json({ error: 'No skills found for this email!' });
        }
    } catch (error) {
        console.error('Error fetching skill by email:', error);
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });
    }
});


// Endpoint: Count all skills
router.get('/count-skills', async (req, res) => {
    try {
        const result = await pool.query('SELECT COUNT(*) FROM SKILL_PESERTA_MAGANG');
        const count = parseInt(result.rows[0].count);
        res.status(200).json({ count: count });
    } catch (error) {
        console.error('Error counting skills:', error);
        res.status(500).json({ error: 'Failed to count skills', details: error.message });
    }
});

// Endpoint: Update a skill by email
router.put('/update-skill-by-email/:email', async (req, res) => {
    const { email } = req.params;  
    const { nama_peserta, departemen, komunikasi, kreativitas, tanggung_jawab, kerja_sama, skill_teknis, banyak_proyek, list_proyek, url_lampiran } = req.body;

    try {
        const result = await pool.query(
            'UPDATE SKILL_PESERTA_MAGANG SET nama_peserta = $1, departemen = $2, komunikasi = $3, kreativitas = $4, tanggung_jawab = $5, kerja_sama = $6, skill_teknis = $7, banyak_proyek = $8, list_proyek = $9, url_lampiran = $10 WHERE email = $11',
            [nama_peserta, departemen, komunikasi, kreativitas, tanggung_jawab, kerja_sama, skill_teknis, banyak_proyek, list_proyek, url_lampiran, email]
        );

        if (result.rowCount > 0) {
            res.status(200).json({ message: 'Skill updated successfully!' });
        } else {
            res.status(404).json({ error: 'No skill found for this email!' });
        }
    } catch (error) {
        console.error('Error updating skill:', error);
        res.status(500).json({ error: 'Failed to update data', details: error.message });
    }
});

// Endpoint: Delete all skills
router.delete('/delete-all-skills', async (req, res) => {  
    try {  
        await pool.query('DELETE FROM SKILL_PESERTA_MAGANG');  
        res.status(200).json({ message: 'All skills have been deleted successfully!' });  
    } catch (error) {  
        console.error('Error deleting skills:', error);  
        res.status(500).json({ error: 'Failed to delete data', details: error.message });  
    }  
});  

// Endpoint: Delete a skill by ID
router.delete('/delete-skill/:id_skill', async (req, res) => {  
    const { id_skill } = req.params;  
    try {  
        const result = await pool.query('DELETE FROM SKILL_PESERTA_MAGANG WHERE id_skill = $1', [id_skill]);  
        if (result.rowCount > 0) {
            res.status(200).json({ message: 'Skill deleted successfully!' });  
        } else {
            res.status(404).json({ error: 'Skill not found!' });
        }
    } catch (error) {  
        console.error('Error deleting skill:', error);  
        res.status(500).json({ error: 'Failed to delete data', details: error.message });  
    }  
});  

module.exports = router;