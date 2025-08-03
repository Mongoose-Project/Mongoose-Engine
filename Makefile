# === Default Target ===
.DEFAULT_GOAL := run

# === Config ===
EXECUTABLE_NAME = mongoose
EXECUTABLE = ./build/$(EXECUTABLE_NAME).exe
SRC_DIR = src
BUILD_DIR = build
SERVICE_NAME = builder
FORMAT_SERVICE_NAME = format

C_SOURCES := $(wildcard $(SRC_DIR)/*.c)
HEADERS := $(wildcard $(SRC_DIR)/*.h)

# === Targets ===
.PHONY: help build run format clean clean-all docker-build docker-up docker-down docker-prune docker-rebuild docker-shell

# === Help Menu ===
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Common targets:"
	@echo "  build             Compile using Docker Compose (only if sources changed)"
	@echo "  Format 		   Format the c files using clang format"
	@echo "  run               Run the compiled binary (auto builds if missing)"
	@echo "  clean             Remove built executable"
	@echo "  clean-all         Remove the entire build folder"
	@echo ""
	@echo "Docker targets:"
	@echo "  docker-build      Build Docker image"
	@echo "  docker-up         Start builder container"
	@echo "  docker-down       Stop and remove containers"
	@echo "  docker-prune      Remove stopped containers"
	@echo "  docker-rebuild    Clean and rebuild everything from scratch"
	@echo "  docker-shell      Open a shell inside the builder container"

# === Docker Targets ===
docker-build:
	docker compose build

docker-up:
	docker compose up $(SERVICE_NAME)

docker-down:
	docker compose down

docker-prune:
	docker container prune -f

docker-rebuild:
	docker compose down --volumes --remove-orphans
	docker compose build --no-cache

docker-shell:
	docker compose run --rm $(SERVICE_NAME) bash

# === Build (Rebuilds if src changes) ===
$(EXECUTABLE): $(C_SOURCES) $(HEADERS)
	docker compose up $(FORMAT_SERVICE_NAME)
	docker compose up $(SERVICE_NAME)
	
build: $(EXECUTABLE)

# === Format the source code files ===
format: 
	@echo "Formatting using clang-format..."
	@docker compose up $(FORMAT_SERVICE_NAME)

# === Run the Executable ===
run: $(EXECUTABLE)
	@clear
	@echo "Running $(EXECUTABLE)..."
	@$(EXECUTABLE)

# === Clean Targets ===
clean:
	rm -f $(EXECUTABLE)

clean-all:
	rm -rf $(BUILD_DIR)
