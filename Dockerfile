# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy only requirements first (for Docker cache efficiency)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variables
ENV FLASK_ENV=production \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Expose Flask default port
EXPOSE 5000

# Run Flask app (using Gunicorn for production)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
