
DOCKER_REGISTRY ?= ghcr.io/privacy-com/ci-images

DOCKERFILES := $(wildcard Dockerfile.*)

build-all:   $(patsubst Dockerfile.%,docker-build-%,$(notdir $(DOCKERFILES)))
publish-all: $(patsubst Dockerfile.%,docker-push-%,$(notdir $(DOCKERFILES)))

docker-build-%: Dockerfile.%
	docker build . -f Dockerfile.$* -t $(DOCKER_REGISTRY):$*

docker-push-%: docker-build-%
	docker push $(DOCKER_REGISTRY):$*

