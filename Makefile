VERSION = $(shell godzil show-version)
CURRENT_REVISION = $(shell git rev-parse --short HEAD)
IMAGE_NAME ?= rust_struct
BUILD_HASH ?= $(shell git rev-parse --verify HEAD 2> /dev/null || echo unknown)

.PHONY: docker.build
docker.build: docker.build-only docker.tag

.PHONY: docker.build-only
docker.build-only:
	docker build . -t $(IMAGE_NAME) --build-arg BUILD_VERSION=$(BUILD_VERSION) --build-arg BUILD_HASH=$(BUILD_HASH)

.PHONY: docker.tag
docker.tag:
ifdef BUILD_VERSION
	docker image tag $(IMAGE_NAME) $(IMAGE_NAME):$(BUILD_VERSION)
endif
