const express = require('express');  
const router = express.Router();  
const { Pool } = require('pg');
const multer = require('multer'); 
const path = require('path');  
require('dotenv').config();  

const pool = new Pool({  
    user: process.env.DB_USER,  
    host: process.env.DB_HOST || 'localhost',  
    database: process.env.DB_DATABASE,  
    password: process.env.DB_PASSWORD,  
    port: process.env.DB_PORT || 5432,  
});  

//////////////////////////////////////////// FILE UPLOADS ///////////////////////////////////////////////////////////////

// Configure multer for file uploads  
const storage = multer.diskStorage({  
    destination: (req, file, cb) => {  
      cb(null, 'uploads/'); // Specify the upload directory -> jpf_internship-api/uploads 
    },  
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now();
        cb(null, file.originalname + '-' + uniqueSuffix +path.extname(file.originalname)); // Ensure unique filenames
    }, 
  });  
  
  const upload = multer({ storage: storage });  
  
  // New route for file upload  
  router.post('/upload-file', upload.single('file'), (req, res) => {  
    if (!req.file) {  
      return res.status(400).json({ error: 'No file uploaded' });  
    }  

    // Path in where the file stored
    const filename = req.file.filename;
    const filePath = `/api/jpf_internship-api/uploads/${filename}`;
  
    return res.status(200).json({ message: 'File uploaded successfully', filePath: filePath });  
  }); 

module.exports = router;  