# Gunakan versi spesifik agar stabil
FROM python:3.14.3-alpine

# Set folder kerja
WORKDIR /app

# Install library sistem tanpa cache agar aman
RUN apk add --no-cache gcc musl-dev linux-headers

# Copy file requirements saja dulu
COPY requirements.txt .

# Install library python tanpa cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh file aplikasi
COPY . .

# Port aplikasi
EXPOSE 5000

# Perintah menjalankan aplikasi
CMD ["python", "app.py"]
