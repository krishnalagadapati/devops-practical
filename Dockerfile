# Create a new Dockerfile that fixes the MongoDB connection issue
FROM node:18-alpine

WORKDIR /app

# Install git to clone the repository
RUN apk add --no-cache git

# Clone the repository
RUN git clone https://github.com/swimlane/devops-practical . && \
    rm -rf .git

# Install dependencies
RUN npm install
COPY . .

# Set default environment variables (can be overridden in Kubernetes)
ENV MONGO_HOST=mongodb-service
ENV MONGO_PORT=27017
ENV MONGO_DB=devops
ENV MONGO_USER=swimlaneuser
ENV MONGO_PASSWORD=swimlanepass
ENV MONGODB_URI=mongodb://swimlaneuser:swimlanepass@${MONGO_HOST}:${MONGO_PORT}/${MONGO_DB}?authSource=admin
# Create a non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Change ownership
RUN chown -R nextjs:nodejs /app

# No server.js modifications here; the app reads DB URL from env at runtime
USER nextjs

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/api/health || exit 1

# Use node directly for production
CMD ["node", "server.js"]

# Patch server.js to ensure it uses the environment variable for MongoDB connection
RUN echo "=== BEFORE PATCH: Checking MongoDB connection in server.js ===" && \
    grep -n "MONGODB_URI\|process.env" server.js && \
    echo "============================================================"