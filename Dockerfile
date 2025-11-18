# Use official Node image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose application port
EXPOSE 8080

# Start the app
CMD ["npm", "start"]
