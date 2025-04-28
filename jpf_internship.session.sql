-- DROP TABLE PENDAFTAR;

-- CREATE TABLE PENDAFTAR (  
--     id_pelamar VARCHAR NOT NULL PRIMARY KEY,    -- ID Pelamar (PK)  
--     nama VARCHAR(100) NOT NULL,           -- Nama  
--     no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
--     email VARCHAR(100) NOT NULL,          -- Email  
--     asal_universitas VARCHAR(100) NOT NULL,          -- Asal Universitas
--     password VARCHAR(15) NOT NULL,                  -- Password
--     role VARCHAR(15) NOT NULL                   -- role : pendaftar
-- );  

SELECT * FROM pendaftar;

CREATE TABLE ADMIN (
    id_admin VARCHAR NOT NULL PRIMARY KEY,    -- ID Admin (PK)  
    nama VARCHAR(100) NOT NULL,           -- Nama  
    no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
    email VARCHAR(100) NOT NULL,          -- Email  
    departemen VARCHAR(20) NOT NULL,          -- Departemen
    password VARCHAR(15) NOT NULL,                  -- Password
    role VARCHAR(15) NOT NULL                   -- role : admin
);