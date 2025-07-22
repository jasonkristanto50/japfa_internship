// email.js
const express = require('express');
const { sendEmail } = require('../email_service'); // Import the email service
const router = express.Router();

// Email message types enum equivalent
const EmailMessageType = {
    daftarMagang: 'daftarMagang',
    daftarKunjungan: 'daftarKunjungan',
    statusMagang: 'statusMagang',
    statusKunjungan: 'statusKunjungan',
    tambahPembimbing: 'tambahPembimbing',
    tambahLinkMeet: 'tambahLinkMeet',
    kirimOtp: 'kirimOtp'
};

// Endpoint to send email
router.post('/send-email', async (req, res) => {
    console.log(req.body); // Log the incoming request body
    const applicationData = req.body; // Expecting application data in the body

    // Extract the necessary fields
    const { email, name, pin, messageType } = applicationData;

    // Construct email information based on the message type
    let subject, text;

    switch (messageType) {
        case EmailMessageType.daftarMagang:
            subject = 'Pendaftaran Magang';
            text = `Salam ${name},\n\nAnda telah berhasil mendaftar untuk program magang di PT Japfa. Silahkan melakukan login untuk melihat status pendaftaran Anda menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nMohon menunggu informasi lebih lanjut.\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.daftarKunjungan:
            subject = 'Pendaftaran Kunjungan';
            text = `Salam ${name},\n\nTerima kasih telah mendaftar untuk kunjungan ke PT Japfa. Silahkan melakukan login untuk melihat status pendaftaran Anda menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nMohon menunggu informasi lebih lanjut.\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.statusMagang:
            subject = 'Status Magang';
            text = `Salam ${name},\n\nSudah ada pembaharuan mengenai status magang Anda. Silahkan melakukan login untuk mendapatkan informasi lengkap menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.statusKunjungan:
            subject = 'Status Kunjungan';
            text = `Salam ${name},\n\nStatus kunjungan Anda telah diperbarui. Silahkan melakukan login untuk melihat detail lebih lanjut menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.tambahPembimbing:
            subject = 'Penambahan Pembimbing';
            text = `Salam ${name},\n\nAnda telah ditambahkan sebagai pembimbing. Silahkan melakukan login untuk menggunakan program sebagai pembimbing menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.tambahLinkMeet:
            subject = 'Link Wawancara';
            text = `Salam ${name},\n\nAnda telah dijadwalkan untuk wawancara. Silahkan melakukan login untuk mendapatkan link wawancara menggunakan:\n- Email: ${email}\n- PIN: ${pin}\n\nSalam,\nTim HR & GA`;
            break;

        case EmailMessageType.kirimOtp:
            subject = 'OTP Japfa Internship';
            text = `Berikut ini adalah kode OTP untuk mengakses program. Silahkan memasukkan kode OTP berikut ini :\n- OTP: ${pin}`;
            break;

        default:
            return res.status(400).json({ message: 'Invalid message type' });
    }

    try {
        await sendEmail(email, subject, text);
        return res.status(200).json({ message: 'Email sent successfully!' });
    } catch (error) {
        console.error('Error sending email:', error);
        // Check if the error message indicates a timeout
        if (error.message === 'Email sending timed out') {
            return res.status(503).json({ message: 'Email gagal dikirimkan - timeout' });
        }
        return res.status(500).json({ message: 'Error sending email' });
    }
});

module.exports = router;