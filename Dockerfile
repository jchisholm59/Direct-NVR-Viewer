# Use a lightweight Node.js image
FROM node:20-slim

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
# Install ffmpeg (used to transcode H.265 event clips to H.264 for browser playback)
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*

RUN npm install

# Copy the rest of the source code
COPY . .

# Expose the default port
EXPOSE 3010

# Start the application
CMD ["npm", "start"]
