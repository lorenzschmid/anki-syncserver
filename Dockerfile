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

# Use PUID and PGID if set, otherwise fallback to default user and group
ARG PUID=1000
ARG PGID=1000

# Create group and user based on PUID and PGID
RUN groupadd -g ${PGID} anki && useradd -u ${PUID} -g anki -m anki

# Set ownership of the working directory and data directory to the new user
RUN chown -R anki:anki /app && chown -R anki:anki /data

# Switch to the non-root user
USER anki

# Run the script to update the package and start the server
CMD ["/app/start.sh"]
