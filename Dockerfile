FROM node:20-alpine

WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy application files
COPY lib/ ./lib/
COPY server.js ./

# Expose the default port
EXPOSE 8080

# Environment variables (can be overridden at runtime)
ENV HOST=0.0.0.0
ENV PORT=8080

# Run as non-root user for security
USER node

CMD ["node", "server.js"]
