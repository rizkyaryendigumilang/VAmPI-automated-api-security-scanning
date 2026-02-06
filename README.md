Markdown
# 🛡️ VAmPI: Ultimate DevSecOps & Hardened Nginx WAF
### The Vulnerable API with Full-Spectrum Security Automation & Runtime Protection

## 📌 Project Overview
VAmPI adalah Flask-based vulnerable API yang mengandung risiko OWASP Top 10 API Security. Proyek ini tidak hanya mendemonstrasikan celah keamanan, tetapi juga mengimplementasikan **Dual-Layer Security Strategy**:

1.  **Shift-Left Security:** Audit otomatis (SAST, SCA, IaC, DAST) terintegrasi.
2.  **Runtime Protection:** Implementasi **Hardened Nginx Reverse Proxy** sebagai Web Application Firewall (WAF) untuk memblokir serangan secara real-time.

---

## 🚀 The Multi-Layer Security Stack

### 🔹 Layer 1: Automated Security Pipeline (Shift-Left)
Orkestrasi via `scan_otomatis.sh` menjalankan audit menyeluruh sebelum aplikasi dianggap aman:
* **Hadolint (IaC):** Audit keamanan Dockerfile untuk memastikan best-practice containerization.
* **Trivy (SCA):** Memindai dependensi pihak ketiga dari kerentanan kritis (CVE).
* **Semgrep (SAST):** Analisis kode statis untuk mendeteksi SQLi, XSS, dan *hardcoded secrets*.
* **OWASP ZAP (DAST):** Simulasi penetrasi pada API yang sedang berjalan.

### 🔹 Layer 2: Hardened Nginx WAF (Defense-in-Depth)
Menambahkan perisai aktif untuk memitigasi serangan yang mungkin lolos dari tahap pengujian:
* **WAF Pattern Matching:** Memblokir payload berbahaya (SQLi/XSS) di level network (403 Forbidden).
* **Security Headers:** Injeksi otomatis CSP, HSTS, X-Frame-Options, dan X-Content-Type-Options.
* **Server Masking:** Menyembunyikan identitas asli Flask/Python untuk mempersulit fase *reconnaissance* penyerang.

---

## 📂 Security Reports & Audit Trail
Seluruh hasil pemindaian dan log monitoring dikumpulkan secara terpusat dalam folder `security_audit_logs/`:

| File Laporan | Kategori | Deskripsi |
| :--- | :--- | :--- |
| `1_hadolint_audit.txt` | IaC | Temuan miskonfigurasi pada Dockerfile. |
| `2_trivy_audit.txt` | SCA | Daftar CVE pada library Python/Alpine. |
| `3_semgrep_audit.txt` | SAST | Analisis celah keamanan pada *source code*. |
| `4_zap_audit.txt` | DAST | Status pengujian dinamis pada endpoint API. |
| `5_waf_alert.txt` | **Incident** | **Log serangan real-time yang diblokir Nginx (Human-Readable).** |

---

## 🔄 Automated Workflow & Incident Response
Sistem ini memastikan respons cepat terhadap ancaman:
1.  **Detection:** Script mendeteksi celah dari infrastruktur hingga kode.
2.  **Protection:** Nginx secara aktif memblokir upaya eksploitasi yang menggunakan karakter berbahaya (seperti `'`, `--`, atau `%27`).
3.  **Instant Alerting:** Sistem menghasilkan file `alert_email_siap_kirim.txt` yang berisi ringkasan serangan (Waktu, IP, dan Path) untuk notifikasi cepat kepada tim Security.

---

## 🔍 Proof of Concept (WAF Blocking)

**Skenario Serangan SQL Injection:**
```bash
# Mencoba serangan melalui port 80 (Nginx WAF)
curl -I "http://localhost/users/v1/_all?id=%27"
Hasil: HTTP/1.1 403 Forbidden Laporan otomatis yang dihasilkan dalam alert_email_siap_kirim.txt:

Plaintext
=== WAF SECURITY ALERT ===
Tanggal: Fri Feb 6 2026

Detail Serangan Terakhir:
🕒 Jam: [06/Feb/2026:13:00:01] | 🌐 IP: 172.18.0.1 | 🚨 Serangan: /users/v1/_all?id=%27
👨‍💻 Project Mission
Proyek ini membuktikan bahwa keamanan bukanlah penghambat, melainkan enabler. Dengan menggabungkan Automated Scanning dan Infrastructure Hardening, kita membangun ekosistem aplikasi yang tidak hanya aman saat dideploy, tetapi juga tangguh menghadapi serangan nyata di lingkungan produksi.
