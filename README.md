# 🛡️ VAmPI: Secure API Pipeline (DevSecOps Implementation)

![Security scanning](https://github.com/rizkyaryendigumilang/VAmPI-Final/actions/workflows/devsecops.yml/badge.svg)
![Build Status](https://img.shields.io/badge/Build-Success-brightgreen)
![DevSecOps](https://img.shields.io/badge/Role-DevSecOps_&_Pentesting-blue)

## 📌 Deskripsi Project
Project ini mendemonstrasikan integrasi keamanan otomatis ke dalam siklus deployment aplikasi (CI/CD). Menggunakan aplikasi **VAmPI** (Vulnerable API) sebagai target, saya telah membangun sistem "Security Guard" otomatis yang melakukan scanning.

## 🚀 Fitur Keamanan (The Success Story)

Sistem ini berhasil menggabungkan tiga pilar utama keamanan informasi:

### 1. **Infrastructure as Code (IaC) Scanning**
* **Tool:** Hadolint
* **Fungsi:** Mendeteksi kesalahan konfigurasi pada `Dockerfile`.
* **Keberhasilan:** Memastikan container berjalan dengan *Best Practices*, mencegah penggunaan *root user* yang berbahaya, dan menjaga ukuran image tetap efisien.

### 2. **Software Supply Chain Security (SCA)**
* **Tool:** Trivy
* **Fungsi:** Memindai library (dependencies) yang ada di `requirements.txt`.
* **Keberhasilan:** Mendeteksi kerentanan kritis (CVE) pada library pihak ketiga secara otomatis sebelum aplikasi dideploy.

### 3. **Dynamic Application Security Testing (DAST)**
* **Tool:** **OWASP ZAP (Zaproxy)**
* **Fungsi:** Melakukan pengujian penetrasi (Pentesting) secara dinamis terhadap aplikasi yang sedang berjalan (runtime).
* **Keterangan:** Menggunakan **ZAP Baseline Scan** untuk memindai endpoint API secara otomatis. Tool ini mensimulasikan serangan nyata dari luar sistem untuk menemukan celah keamanan yang tidak terlihat pada code sumber (static), seperti kerentanan pada respon HTTP dan konfigurasi server.
* **Keberhasilan:** Berhasil mendeteksi celah kritis seperti *Missing Security Headers*, *Storable and Cacheable Content*, serta *Site Isolation Issues (Spectre)* pada aplikasi runtime.

---

## 🛠️ Alur Kerja DevSecOps (Automation)

Setiap kali saya melakukan `git push`, robot **GitHub Actions** menjalankan tugas berikut secara otomatis:

1. **Automated Scanning:** Menjalankan script `scan_otomatis.sh` yang merangkum seluruh temuan.
2. **Container Testing:** Membangun dan menjalankan aplikasi di lingkungan virtual yang terisolasi.
3. **Security Pentest:** **OWASP ZAP** menyerang aplikasi yang aktif untuk mencari celah keamanan nyata (Dynamic Analysis).
4. **Instant Reporting:** Mengirimkan laporan detail (`.txt` & log) langsung ke email saya sebagai pemberitahuan hasil scanning.

---

## 📂 Struktur Laporan Otomatis
Laporan yang dihasilkan oleh sistem ini meliputi:
* `hasil_scan_lengkap.txt`: Rekaman seluruh proses scanning terminal dari script otomatisasi.
* `hadolint-report.txt`: Detail kepatuhan keamanan Docker.(IaC)
* `trivy-report.txt`: Daftar kerentanan pada library aplikasi (SCA).
* `zap-log.txt`: Hasil pengujian penetrasi dinamis (DAST) dari OWASP ZAP.

---

## 👨‍💻 Tujuan Project
Project ini membuktikan bahwa keamanan bukan lagi penghambat kecepatan coding, melainkan bagian dari otomatisasi. Dengan sistem ini, kerentanan dapat ditemukan dan diperbaiki **lebih awal** (*Shift-Left Security*) sebelum mencapai tangan pengguna.
