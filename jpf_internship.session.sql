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
--     jumlah_anak INTEGER NOT NULL,          -- Jumlah Anak (max 100)
--     tanggal_kegiatan VARCHAR(20) NOT NULL              -- Tanggal kegiatan
-- );