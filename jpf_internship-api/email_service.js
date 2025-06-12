const nodemailer = require('nodemailer');
require('dotenv').config();

// Create a transporter object
// const transporter = nodemailer.createTransport({
//   service: 'gmail',
//   auth: {
//     user: process.env.EMAIL_USER,
//     port: 2525,
//     pass: process.env.EMAIL_PASSWORD
//   },
// });

// Create a transporter object
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,          // smtp.sendgrid.net
  port: Number(process.env.SMTP_PORT),  // 2525
  secure: false,                        // STARTTLS
  auth: {
    user: process.env.SMTP_USER,        // 'apikey'
    pass: process.env.SENDGRID_KEY      // the new SG.… token
  }
});

// test the credentials once at boot
transporter.verify((err, ok) => {
  if (err) {
    console.error('SMTP VERIFY ERROR →', err);
  } else {
    console.log('SMTP connection ready');
  }
});

// Function to send email with timeout
const sendEmail = (recipient, subject, text, timeout = 10000) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: recipient,
    subject: subject,
    text: text,
  };

  return new Promise((resolve, reject) => {
    // Create a timeout promise
    const timeoutPromise = new Promise((_, reject) => {
      setTimeout(() => {
        reject(new Error('Email sending timed out'));
      }, timeout);
    });

    // Create the sendMail promise
    const sendMailPromise = transporter.sendMail(mailOptions)
      .then(info => {
        console.log('Email sent:', info.response);
        resolve(info);
      })
      .catch(error => {
        console.error('Error sending email:', error);
        reject(error);
      });

    // Race between the sendMail and timeout
    Promise.race([sendMailPromise, timeoutPromise])
      .then(resolve)   // Resolve if sending was successful
      .catch(reject);  // Reject if timeout or sending failed
  });
};

module.exports = { sendEmail };