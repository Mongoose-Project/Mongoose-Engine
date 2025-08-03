# Mongoose Builder – Dockerized C/C++ Build System

This project uses `Makefile` and `Docker Compose` to build and run a C/C++ application in a consistent, containerized environment. It's ideal for cross-platform development or when you want to avoid setting up toolchains locally.

## Requirements

* Docker
* Docker Compose
* GNU Make

## Common Usage

### Build the Project

```bash
make build
```

This will use Docker to compile the source code inside the builder container.

### Run the Binary

```bash
make run
```

This will check if the executable exists. If not, it triggers the build and runs the compiled binary (`./build/mongoose.exe`).

### Clean Compiled Files

```bash
make clean        # Deletes only the executable
make clean-all    # Deletes the entire build folder
```

## Docker Targets

All Docker commands are wrapped with make targets for convenience:

| Command             | Description                              |
| ------------------- | ---------------------------------------- |
| make docker-build   | Build the Docker image                   |
| make docker-up      | Start the builder container              |
| make docker-down    | Stop and remove containers               |
| make docker-prune   | Remove all stopped containers            |
| make docker-rebuild | Fully rebuild from scratch (clean build) |
| make docker-shell   | Drop into a shell inside the container   |

## Default Behavior

The default goal is `run`. So simply running:

```bash
make
```

...will automatically build (if necessary) and run the application.

## Configuration (in `Makefile`)

You can customize the build setup by adjusting these variables:

```makefile
EXECUTABLE_NAME = mongoose       # Name of the output binary
SRC_DIR         = src            # Source folder
BUILD_DIR       = build          # Output folder
IMAGE_NAME      = mongoose-builder  # Docker image name
SERVICE_NAME    = builder        # Docker Compose service
```

## Notes

* Assumes a valid `Dockerfile` and `docker-compose.yml` setup for building C/C++ inside a container.
* Supports `.exe` output for compatibility with Windows hosts.

## License

This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file in the repository for full details.
