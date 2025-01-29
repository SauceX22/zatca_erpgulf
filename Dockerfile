# Use a minimal Python-based Linux image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl git redis mariadb-client nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Install Frappe Bench globally
RUN pip install frappe-bench

# Copy application code
COPY . .

# Initialize Frappe inside the container (optional if not already initialized)
RUN bench init --frappe-branch version-14 /app/frappe-bench && \
    cd /app/frappe-bench && \
    bench get-app erpnext --branch version-14

# Set working directory to Frappe bench
WORKDIR /app/frappe-bench

# Expose a port (change as needed)
EXPOSE 8000

# Command to start Frappe Bench
CMD ["bench", "start"]
