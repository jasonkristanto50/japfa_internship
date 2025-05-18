-- DROP TABLE PENDAFTAR;

-- CREATE TABLE PENDAFTAR (  
--     id_pendaftar VARCHAR NOT NULL PRIMARY KEY,    -- ID Pelamar (PK)  
--     nama VARCHAR(100) NOT NULL,           -- Nama  
--     no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
--     email VARCHAR(100) NOT NULL,          -- Email  
--     asal_universitas VARCHAR(100) NOT NULL,          -- Asal Universitas
--     password VARCHAR(15) NOT NULL,                  -- Password
--     role VARCHAR(15) NOT NULL                   -- role : pendaftar
-- );  

-- SELECT * FROM pendaftar;

-- DROP TABLE ADMIN;

-- CREATE TABLE ADMIN (
--     id_admin VARCHAR NOT NULL PRIMARY KEY,    -- ID Admin (PK)  
--     nama VARCHAR(100) NOT NULL,           -- Nama  
--     no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
--     email VARCHAR(100) NOT NULL,          -- Email  
--     departemen VARCHAR(20) NOT NULL,          -- Departemen
--     password VARCHAR(15) NOT NULL,                  -- Password
--     role VARCHAR(15) NOT NULL,                 -- role : admin
--     status VARCHAR NOT NULL               -- status : aktif / tidak aktif
-- );

-- DROP TABLE KUNJUNGAN_STUDI;

-- CREATE TABLE KUNJUNGAN_STUDI (
--     id_kunjungan_studi VARCHAR NOT NULL PRIMARY KEY,    -- ID Kunjungan Studi (PK)  
--     nama_perwakilan VARCHAR(100) NOT NULL,           -- Nama  
--     no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
--     email VARCHAR(100) NOT NULL,          -- Email  
--     asal_universitas VARCHAR(100) NOT NULL,     -- Asal universitas
--     jumlah_peserta INTEGER NOT NULL,          -- Jumlah Peserta (max 55)
--     tanggal_kegiatan VARCHAR(20) NOT NULL,              -- Tanggal kegiatan
--     jam_kegiatan VARCHAR(20) NOT NULL,
--     path_persetujuan_instansi VARCHAR(255) NOT NULL,
--     status VARCHAR NOT NULL,                    -- Menunggu / diterima / ditolak
--     catatan_hr VARCHAR(255),                 
--     password_token VARCHAR(255)
-- );

DROP TABLE PESERTA_MAGANG;

CREATE TABLE PESERTA_MAGANG (  
    id_magang VARCHAR PRIMARY KEY NOT NULL,  
    nama VARCHAR(255) NOT NULL,
    departemen VARCHAR(255),  
    alamat VARCHAR(255) NOT NULL,  
    no_telp VARCHAR(255) NOT NULL,  
    email VARCHAR(255) NOT NULL,  
    asal_universitas VARCHAR(255) NOT NULL,  
    angkatan INTEGER NOT NULL,  
    nilai_univ FLOAT NOT NULL,  
    jurusan VARCHAR(255) NOT NULL,  
    path_cv  VARCHAR(255) NOT NULL,
    path_persetujuan_univ  VARCHAR(255) NOT NULL,
    path_transkrip_nilai  VARCHAR(255) NOT NULL,
    path_foto_diri VARCHAR(255) NOT NULL,
    status_magang VARCHAR(50) NOT NULL,
    password_token VARCHAR,
    path_surat_penerimaan VARCHAR(255),
    link_meet_interview VARCHAR(255),
    catatan_hr VARCHAR(255),
    nama_pembimbing VARCHAR(255),
    url_laporan_akhir VARCHAR(255),     
    nilai_akhir_magang INTEGER  
);  

-- Ada 5 Jenis Status Magang: 
-- - On Process
-- - Sedang Berlangsung
-- - Diterima
-- - Selesai
-- - Ditolak
-- 
-- - Tidak dilanjutkan
-- - Tidak jadi



-- DROP TABLE DEPARTEMEN;

-- CREATE TABLE DEPARTEMEN (  
--     id_departemen VARCHAR PRIMARY KEY NOT NULL,  
--     nama_departemen VARCHAR(255) NOT NULL,
--     deskripsi VARCHAR(255),  
--     syarat_departemen TEXT[],
--     path_image  VARCHAR NOT NULL,
--     max_kuota INTEGER,  
--     jumlah_pengajuan INTEGER,  
--     jumlah_approved INTEGER,  
--     jumlah_on_boarding INTEGER,  
--     sisa_kuota INTEGER
-- );  

-- DROP TABLE LOGBOOK_PESERTA_MAGANG;

-- CREATE TABLE LOGBOOK_PESERTA_MAGANG (  
--     id_logbook VARCHAR PRIMARY KEY NOT NULL,  
--     nama_peserta VARCHAR(255) NOT NULL,
--     departemen VARCHAR(255),  
--     email VARCHAR(255) NOT NULL,
--     nama_aktivitas VARCHAR(255) NOT NULL,
--     tanggal_aktivitas VARCHAR(255) NOT NULL,
--     url_lampiran VARCHAR(255) NOT NULL,
--     validasi_pembimbing VARCHAR(255) DEFAULT NULL,
--     catatan_pembimbing VARCHAR(255) DEFAULT NULL
-- );  