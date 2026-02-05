#!/bin/bash

# --- KONFIGURASI ---
EMAIL="rizkyaryendigumilang@gmail.com"
LAPORAN="$HOME/VAmPI/laporan_keamanan.txt"
URL_TARGET="http://localhost:5000"

echo "==============================================="
echo "   MEMULAI OTOMATISASI DEVSECOPS - VAmPI       "
echo "==============================================="

# 1. Bersihkan laporan lama
echo "Bersiap..." > $LAPORAN
echo "Waktu scanning: $(date)" >> $LAPORAN
echo "-----------------------------------------------" >> $LAPORAN

# 2. STEP 1: Scan Infrastruktur (Hadolint)
echo "[+] Menjalankan Hadolint pada Dockerfile..."
echo -e "\n[1. INFRASTRUCTURE SCAN - HADOLINT]" >> $LAPORAN
docker run --rm -i hadolint/hadolint < Dockerfile >> $LAPORAN 2>&1
echo "Selesai."

# 3. STEP 2: Scan Dependensi (Trivy)
echo "[+] Menjalankan Trivy pada Requirements..."
echo -e "\n[2. DEPENDENCY SCAN - TRIVY]" >> $LAPORAN
trivy fs --skip-dirs SecLists --severity HIGH,CRITICAL . >> $LAPORAN 2>&1
echo "Selesai."

# 4. STEP 3: Jalankan Aplikasi & Scan Serangan (ZAP)
echo "[+] Menjalankan Aplikasi VAmPI & OWASP ZAP..."
# Jalankan VAmPI di background
python3 app.py > /dev/null 2>&1 &
APP_PID=$!
sleep 5 # Tunggu aplikasi benar-benar nyala

echo -e "\n[3. DYNAMIC SCAN - OWASP ZAP]" >> $LAPORAN
docker run --rm --network="host" -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
    -t $URL_TARGET | grep -E "PASS|WARN|FAIL" >> $LAPORAN 2>&1

# Matikan aplikasi setelah scan selesai
kill $APP_PID
echo "Selesai."

# 5. KIRIM LAPORAN VIA GMAIL (msmtp)
echo "[+] Mengirim hasil ke email $EMAIL..."
(
  echo "Subject: [Otomatis] Laporan Keamanan VAmPI - $(date +'%d/%m/%Y')"
  echo "To: $EMAIL"
  echo "From: $EMAIL"
  echo ""
  cat $LAPORAN
) | msmtp -a default $EMAIL

echo "==============================================="
echo "   SEMUA PROSES SELESAI & EMAIL TERKIRIM!     "
echo "==============================================="
