# Gunakan Node versi LTS
FROM node:22

# Install PM2 global
RUN npm install -g pm2

# Buat direktori kerja
WORKDIR /app

# Salin file package
COPY package*.json ./

# Install dependencies
RUN npm install

# Salin semua file
COPY . .

# Jalankan server
# CMD ["npm", "start"]
CMD ["pm2-runtime", "ecosystem.config.js"]
