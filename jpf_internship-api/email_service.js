// emailService.js
const nodemailer = require('nodemailer');

// Create a transporter object
const transporter = nodemailer.createTransport({
  service: 'gmail', // or your email provider
  auth: {
    user: process.env.EMAIL_USER, // Your email address from .env
    pass: process.env.EMAIL_PASSWORD // Your email password or app password
  },
});

// Function to send email
const sendEmail = (recipient, subject, text) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: recipient,
    subject: subject,
    text: text,
  };

  return transporter.sendMail(mailOptions)
    .then(info => {
      console.log('Email sent:', info.response);
    })
    .catch(error => {
      console.error('Error sending email:', error);
    });
};

module.exports = { sendEmail };