// email.js
const express = require('express');
const { sendEmail } = require('../email_service'); // Import the email service
const router = express.Router();

// Endpoint to send email
router.post('/send-email', async (req, res) => {
    console.log(req.body); // Log the incoming request body
    const applicationData = req.body; // Expecting application data in the body

    // Construct email information
    const recipient = applicationData.email;
    const subject = 'Application Confirmation';
    const text = `Hello ${applicationData.name},\n\nYour application has been received! We will get back to you soon.\n\nBest regards,\nYour Company`;

    try {
        await sendEmail(recipient, subject, text);
        return res.status(200).json({ message: 'Email sent successfully!' });
    } catch (error) {
        console.error('Error sending email:', error);
        return res.status(500).json({ message: 'Error sending email' });
    }
});

module.exports = router;