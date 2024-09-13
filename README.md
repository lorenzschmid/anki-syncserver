# Anki Sync Server Docker Container

This docker container simply wraps the official minimal sync server based on Python. More information can be found in the [official documentation](https://docs.ankiweb.net/sync-server.html).


## Configuration

The docker container uses the same environmental variable as described in the [official documentation](https://docs.ankiweb.net/sync-server.html). For more information, please consult it directly. The following environmental variables are bound to the container's setup and therefore, should not be changed:

- `SYNC_BASE`
- `SYNC_HOST`
- `SYNC_PORT`

At least the following environmental variables has to be set outside of the container:

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


## Updating the Docker Container

Upon each restart, the docker container verifies that it runs with the most recent version of the official sync server and updates automatically if a new version is available. The docker image itself likely does not need an update.


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
