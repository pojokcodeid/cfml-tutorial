FROM ortussolutions/commandbox:latest

# Set working directory ke /app
WORKDIR /app

# Salin app source code dan box.json
COPY ./app /app

# Install dependency dari box.json
RUN box install

# Pastikan port default terbuka
EXPOSE 8888 443
