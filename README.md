# Language Learning App

Language Learning App adalah aplikasi yang dirancang untuk membantu pengguna mempelajari bahasa baru secara efektif dan interaktif. Proyek ini terdiri dari dua bagian utama: backend (be) yang menggunakan Node.js dan frontend (fe) yang menggunakan Flutter.

## Fitur

- **Pelajaran Terstruktur**: Pelajaran disusun berdasarkan level kesulitan.
- **Latihan Interaktif**: Berbagai jenis latihan seperti pilihan ganda, benar/salah, dan isi kata kosong.
- **Konten Media**: Pelajaran dapat menyertakan gambar untuk mendukung konten.
- **Navigasi Mudah**: Menggunakan `GetX` untuk navigasi yang mudah dan manajemen state.

## Struktur Proyek

```plaintext
.
├── be
│   ├── controllers
│   ├── models
│   ├── routes
│   ├── app.js
│   └── ...
├── fe
│   ├── lib
│   │   ├── controllers
│   │   ├── models
│   │   ├── screens
│   │   ├── services
│   │   └── main.dart
│   └── ...
├── README.md
└── ...
```

## Backend (Node.js)

### Fitur Backend Utama

- Sistem autentikasi dengan JWT
- Penghitungan XP berdasarkan kinerja pengguna
- Pelacakan kemajuan pelajaran dan materi
- API untuk mengelola pelajaran, latihan, dan kemajuan pengguna

## Frontend (Flutter)

### Fitur Frontend Utama

- Navigasi mudah menggunakan GetX
- Tampilan responsif untuk berbagai ukuran layar
- Integrasi dengan API backend untuk mengambil dan mengirim data
- Tampilan interaktif untuk pelajaran dan latihan

## Instalasi dan Penggunaan

1. **Clone the repository**

  ```bash
  git clone https://github.com/Motherbloods/Inggris-Learning-App.git
  cd Inggris-Learning-App
  ```

2. **Instal dependencies untuk backend (Node JS)**:

  ```bash
  cd be
  npm install
  ```

3. **Instal dependencies untuk frontend (Flutter)**:

  ```bash
  cd fe
  flutter pub get
  ```

4. Atur variabel lingkungan di file `.env`
5. Jalankan server backend:

  ```bash
  node app.js
  ```

6. Jalankan aplikasi Flutter:

  ```bash
  flutter run
  ```

## Kontribusi
Kontribusi selalu diterima dengan baik. Silakan buat pull request atau buka issue untuk saran dan perbaikan.

## Kontak
[Habib Risky Kurniawan] - [motherbloodss
