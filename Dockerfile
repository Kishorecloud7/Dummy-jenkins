# Use proper Node version
FROM node:18

# Set working directory
WORKDIR /app

# Copy only package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose and start
EXPOSE 3000
CMD ["npm", "start"]
