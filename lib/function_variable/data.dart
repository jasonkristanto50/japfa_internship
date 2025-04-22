// List department dengan deskripsi
List<Map<String, String>> cards = [
  {
    'title': 'Department 1',
    'description': 'Ini adalah isi dari departemen 1',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
  {
    'title': 'Department 2',
    'description': 'Apakah ini no 2',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
  {
    'title': 'Department 3',
    'description':
        'Ppppppppppppppppppppoiuytredfeofwefhufwioefhuwefjwefiowefpojei',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
  {
    'title': 'Card 4',
    'description': 'For card 4, consider adding some exciting information.',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
  {
    'title': 'Card 5',
    'description': 'The description for card 5 could include a special note.',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
  {
    'title': 'Card 6',
    'description': 'Lastly, card 6 can have its own unique content as well.',
    'image': 'assets/japfa_buduran_landscape.jpg',
  },
];

final List<Map<String, dynamic>> pengajuanDepartemen = [
  {
    'department': 'HR&GA',
    'maxQuota': 10,
    'totalApplications': 36,
    'approved': 4,
    'onboarding': 2,
    'remainingQuota': 6,
  },
  {
    'department': 'IT',
    'maxQuota': 10,
    'totalApplications': 36,
    'approved': 4,
    'onboarding': 2,
    'remainingQuota': 6,
  },
  {
    'department': 'Koperasi Karyawan',
    'maxQuota': 10,
    'totalApplications': 36,
    'approved': 4,
    'onboarding': 2,
    'remainingQuota': 6,
  },
  {
    'department': 'Pet Food - PIB',
    'maxQuota': 12,
    'totalApplications': 40,
    'approved': 6,
    'onboarding': 3,
    'remainingQuota': 6,
  },
  {
    'department': 'Produksi',
    'maxQuota': 8,
    'totalApplications': 25,
    'approved': 3,
    'onboarding': 1,
    'remainingQuota': 4,
  },
  {
    'department': 'QC & Lab',
    'maxQuota': 15,
    'totalApplications': 50,
    'approved': 8,
    'onboarding': 5,
    'remainingQuota': 7,
  },
  {
    'department': 'Sales & Marketing',
    'maxQuota': 9,
    'totalApplications': 30,
    'approved': 5,
    'onboarding': 2,
    'remainingQuota': 4,
  },
  {
    'department': 'Silo & Dryer',
    'maxQuota': 7,
    'totalApplications': 22,
    'approved': 4,
    'onboarding': 2,
    'remainingQuota': 3,
  },
  {
    'department': 'Teknik',
    'maxQuota': 12,
    'totalApplications': 28,
    'approved': 7,
    'onboarding': 3,
    'remainingQuota': 5,
  },
  {
    'department': 'Warehouse',
    'maxQuota': 14,
    'totalApplications': 45,
    'approved': 6,
    'onboarding': 3,
    'remainingQuota': 8,
  },
];

final List<String> departments = [
  'HR&GA',
  'IT',
  'Koperasi Karyawan',
  'Pet Food - PIB',
  'Produksi',
  'QC & Lab',
  'Sales & Marketing',
  'Silo & Dryer',
  'Teknik',
  'Warehouse',
];

final List<Map<String, dynamic>> kunjunganData = [
  {
    'nama': 'Kunjungan Universitas A',
    'asal universitas': 'Universitas A',
    'jumlah anak': 20,
    'tanggal kegiatan': '10/05/2023', // Change to string format
    'status': 'Selesai', // Status can be "Selesai", "Menunggu", etc.
  },
  {
    'nama': 'Kunjungan Universitas B',
    'asal universitas': 'Universitas B',
    'jumlah anak': 15,
    'tanggal kegiatan': '15/06/2023', // Change to string format
    'status': 'Berlangsung',
  },
  {
    'nama': 'Kunjungan Universitas C',
    'asal universitas': 'Universitas C',
    'jumlah anak': 10,
    'tanggal kegiatan': '20/07/2023', // Change to string format
    'status': 'Direncanakan',
  },
  {
    'nama': 'Kunjungan Universitas D',
    'asal universitas': 'Universitas D',
    'jumlah anak': 25,
    'tanggal kegiatan': '05/08/2023', // Change to string format
    'status': 'Selesai',
  },
];

final List<Map<String, dynamic>> detailPengajuanData = [
  {
    'nama': 'Andi Sutrisno',
    'departemen': 'Admin Sales',
    'universitas': 'Universitas Indonesia',
    'jurusan': 'Manajemen',
    'angkatan': '2022',
    'ipk': '3.5',
    'cv': 'assets/cv_andi_sutrisno.pdf',
    'dokumen_persetujuan': 'assets/dokumen_persetujuan_andi.pdf',
    'transkrip_nilai': 'assets/transkrip_nilai_andi.pdf',
    'email': 'andi.sutrisno@example.com',
    'no_telp': '081234567890',
    'alamat': 'Jl. Melati No. 5, Jakarta',
  },
  {
    'nama': 'Budi Santoso',
    'departemen': 'Finance',
    'universitas': 'Universitas Gadjah Mada',
    'jurusan': 'Akuntansi',
    'angkatan': '2023',
    'ipk': '3.8',
    'cv': 'assets/cv_budi_santoso.pdf',
    'dokumen_persetujuan': 'assets/dokumen_persetujuan_budi.pdf',
    'transkrip_nilai': 'assets/transkrip_nilai_budi.pdf',
    'email': 'budi.santoso@example.com',
    'no_telp': '082345678901',
    'alamat': 'Jl. Kenanga No. 10, Yogyakarta',
  },
  {
    'nama': 'Cici Rahmawati',
    'departemen': 'Human Resources',
    'universitas': 'Universitas Airlangga',
    'jurusan': 'Psikologi',
    'angkatan': '2021',
    'ipk': '3.6',
    'cv': 'assets/cv_cici_rahmawati.pdf',
    'dokumen_persetujuan': 'assets/dokumen_persetujuan_cici.pdf',
    'transkrip_nilai': 'assets/transkrip_nilai_cici.pdf',
    'email': 'cici.rahmawati@example.com',
    'no_telp': '083456789012',
    'alamat': 'Jl. Mawar No. 15, Surabaya',
  },
  {
    'nama': 'Dodi Pranata',
    'departemen': 'Marketing',
    'universitas': 'Univ. Diponegoro',
    'jurusan': 'Ilmu Komunikasi',
    'angkatan': '2022',
    'ipk': '3.4',
    'cv': 'assets/cv_dodi_pranata.pdf',
    'dokumen_persetujuan': 'assets/dokumen_persetujuan_dodi.pdf',
    'transkrip_nilai': 'assets/transkrip_nilai_dodi.pdf',
    'email': 'dodi.pranata@example.com',
    'no_telp': '084567890123',
    'alamat': 'Jl. Kamboja No. 20, Semarang',
  },
  // Add more entries as needed.
];

final List<Map<String, dynamic>> logbookData = [
  {
    'no': 1,
    'aktivitas': 'Presentasi dan Knowledge Sharing',
    'tanggal_kegiatan': '29-11-2024',
    'url': 'http://example.com/url1',
    'status': 'Selesai', // Instead of validasi
    'catatan_pembimbing': 'Catatan 1',
  },
  {
    'no': 2,
    'aktivitas': 'Bug fixing Aplikasi Messaging',
    'tanggal_kegiatan': '28-11-2024',
    'url': 'http://example.com/url2',
    'status': 'Selesai',
    'catatan_pembimbing': 'Catatan 2',
  },
  {
    'no': 3,
    'aktivitas': 'Demo aplikasi pada Mitra',
    'tanggal_kegiatan': '25-11-2024',
    'url': 'http://example.com/url3',
    'status': 'Mengunggu', // Different status
    'catatan_pembimbing': 'Catatan 3',
  },
  {
    'no': 4,
    'aktivitas': 'Pengujian Aplikasi',
    'tanggal_kegiatan': '26-11-2024',
    'url': 'http://example.com/url4',
    'status': 'Belum Selesai',
    'catatan_pembimbing': 'Catatan 4',
  },
  {
    'no': 5,
    'aktivitas': 'Pengembangan Fitur Baru',
    'tanggal_kegiatan': '30-11-2024',
    'url': 'http://example.com/url5',
    'status': 'Selesai',
    'catatan_pembimbing': 'Catatan 5',
  },
];
