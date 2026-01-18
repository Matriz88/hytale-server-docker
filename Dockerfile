FROM eclipse-temurin:25-jre

# Install unzip for extracting the downloaded zip file
RUN apt-get update && apt-get install -y unzip curl && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Download hytale-downloader
RUN curl -L -o hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip && \
    unzip hytale-downloader.zip && \
    chmod +x hytale-downloader-linux-amd64 && \
    rm hytale-downloader.zip

# Create directory for server files
RUN mkdir -p /server

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables
ENV DOWNLOADER_PATH=/app/hytale-downloader-linux-amd64
ENV SERVER_PATH=/server

# Expose Hytale server port
EXPOSE 5520

# Use entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
