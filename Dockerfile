# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set PUID/PGID build arguments
ARG PUID=1000
ARG PGID=1000

# Create a non-root user and group first
RUN groupadd -g ${PGID} anki && useradd -u ${PUID} -g anki -m anki

# Set environment variables
ENV PATH="/app/.venv/bin:$PATH"
ENV SYNC_BASE=/data
ENV SYNC_HOST=0.0.0.0
ENV SYNC_PORT=8080
ENV UPDATE_INTERVAL=604800

# Create app, venv and data directories
RUN mkdir -p /app /data && \
    python3 -m venv /app/.venv

# Install dependencies
RUN pip install anki

# Copy application files
COPY . /app

# Set ownership
RUN chown -R anki:anki /app /data

# Set the working directory
WORKDIR /app

# Expose the port
EXPOSE 8080

# Switch to the non-root user
USER anki

# Run the start script
CMD ["/app/start.sh"]
