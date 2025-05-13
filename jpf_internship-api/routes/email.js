// email.js
const express = require('express');
const { sendEmail } = require('../email_service'); // Import the email service
const router = express.Router();

// Endpoint to send email
router.post('/send-email', async (req, res) => {
    console.log(req.body); // Log the incoming request body
    const applicationData = req.body; // Expecting application data in the body

    // Extract the name and PIN from the request body
    const { name, pin } = applicationData;

    // Construct email information
    const recipient = applicationData.email;
    const subject = 'Konfirmasi Pengajuan';
    const text = `Salam ${name},\n\nPengajuan anda sudah diterima. Silahkan login gunakan "PIN: ${pin}" untuk melihat status pengajuan. Mohon menunggu\n\nSalam,\nYour Best Friend`;

    try {
        await sendEmail(recipient, subject, text);
        return res.status(200).json({ message: 'Email sent successfully!' });
    } catch (error) {
        console.error('Error sending email:', error);
        return res.status(500).json({ message: 'Error sending email' });
    }
});

module.exports = router;