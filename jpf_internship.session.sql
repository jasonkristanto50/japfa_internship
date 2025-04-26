DROP TABLE PENDAFTAR;

CREATE TABLE PENDAFTAR (  
    id_pelamar VARCHAR NOT NULL PRIMARY KEY,    -- ID Pelamar (PK)  
    nama VARCHAR(100) NOT NULL,           -- Nama  
    no_telp VARCHAR(15) NOT NULL,                 -- No Telp  
    email VARCHAR(15) NOT NULL,          -- Email  
    asal_universitas VARCHAR(15) NOT NULL,          -- Asal Universitas
    password VARCHAR(15) NOT NULL,                  -- Password
    role VARCHAR(15) NOT NULL                   -- role : pendaftar
);  

SELECT * FROM pendaftar