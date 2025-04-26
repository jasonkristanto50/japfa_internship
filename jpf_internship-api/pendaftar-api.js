// Sample endpoint: Create a new user in the pendaftar table  
app.post('/api/pendaftar', async (req, res) => {  
    const { id_pelamar, nama, no_telp, email, asal_universitas, password } = req.body;  

    try {  
        console.log('Received data:', req.body);  // Log received data  
        const result = await pool.query(  
            'INSERT INTO pendaftar (id_pelamar, nama, no_telp, email, asal_universitas, password) VALUES ($1, $2, $3, $4, $5, $6)',  
            [id_pelamar, nama, no_telp, email, asal_universitas, password]  
        );  
        res.status(201).json({ message: 'User created successfully!' });  
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

app.get('/api/pendaftar/count', (req, res) => {  
    db.query('SELECT COUNT(*) AS count FROM pendaftar', (error, results) => {  
        if (error) {  
            return res.status(500).send(error);  
        }  
        // Ensure the count is returned as an integer  
        const count = parseInt(results[0].count, 10); // Convert to integer  
        res.json({ count: count });  
    });  
});

// New GET endpoint to fetch all users in the pendaftar table  
router.get('/', async (req, res) => {  
    try {  
        const result = await pool.query('SELECT * FROM pendaftar');  
        res.status(200).json(result.rows); // Return the rows as JSON  
    } catch (error) {  
        console.error('Error fetching data:', error);  
        res.status(500).json({ error: 'Failed to fetch data', details: error.message });  
    }  
});  