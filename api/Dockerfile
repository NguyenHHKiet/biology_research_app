# Stage 1: Build dependencies
FROM node:18-alpine AS build

# Set working directory
WORKDIR /usr/src/app

# Copy package files first to leverage docker caching
COPY package*.json ./

# Install dependencies
# Use npm ci for more reliable dependency installation in production
RUN npm ci --only=production

# Stage 2: Production environment
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Install only production dependencies
COPY --from=build /usr/src/app/node_modules ./node_modules

# Copy application files
COPY . .

# Remove any development or unnecessary files
RUN rm -rf test .git .gitignore

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Change ownership of the application directory
RUN chown -R appuser:appgroup /usr/src/app

# Switch to non-root user
USER appuser

# Expose the port the app runs on
EXPOSE ${API_PORT}

# Set environment to production
ENV NODE_ENV=production

# Health check (optional)
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:${API_PORT}/health || exit 1

# Command to run the application
CMD ["npm", "start"]