# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the Anki sync server
RUN pip install anki

# Set environment variables for the sync server (do not change)
ENV SYNC_BASE=/data
ENV SYNC_HOST=0.0.0.0
ENV SYNC_PORT=8080

# Create the data directory
RUN mkdir -p /data

# Expose the port the sync server runs on
EXPOSE 8080

# Run the script to update the package and start the server
CMD ["/app/start.sh"]
