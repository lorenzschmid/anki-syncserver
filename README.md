# Anki Sync Server Docker Container

This docker container simply wraps the official minimal sync server based on Python. More information can be found in the [official documentation](https://docs.ankiweb.net/sync-server.html).


## Configuration

The docker container uses the same environmental variable as described in the [official documentation](https://docs.ankiweb.net/sync-server.html). Some meaningful defaults are set. One might want to change the following environmental variables:

- `SYNC_USER1`: The username and password for the first user in the format `user:password`.


## Running the Docker Container

To start the Anki sync server in a Docker container:

```sh
docker run \
  -d \
  --name anki-syncserver \
  -p 8080:8080 \
  -v ./data:/data \
  -e SYNC_USER1=user:password \
  ghcr.io/lorenzschmid/anki-syncserver
```

- `-d`: Runs the container in detached mode.
- `--name`: Assigns a name to the container (`anki-syncserver`).
- `-p 8080:8080`: Maps port `8080` on the host to port `8080` in the container.
- `-v ./data:/data`: Mounts the host directory `./data` to the container’s `/data` directory for data persistence.
- `-e SYNC_USER1=user:password`: Sets the `SYNC_USER1` environment variable to configure the sync server’s username and password.

or via docker compose:

```yaml
version: '3.8'

services:
  anki-syncserver:
    image: ghcr.io/lorenzschmid/anki-syncserver
    container_name: anki-syncserver
    environment:
      SYNC_USER1: "user:password"  # Replace with your desired username:password
    ports:
      - "8080:8080"
    volumes:
      - "./data:/data"
    restart: unless-stopped
```


## Building the Docker Image Locally

1. Clone this Repository:
   ```sh
   git clone https://github.com/lorenzschmid/anki-syncserver.git
   cd anki-syncserver
   ```

2. Build the Docker Image:
   Run the following command in the directory containing your `Dockerfile`:
   ```sh
   docker build -t anki-syncserver .
   ```

   This command builds the Docker image and tags it as `anki-syncserver`.
