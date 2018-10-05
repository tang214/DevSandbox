NAME = burnerdev/apache-directory-studio
VERSION = 2.0.0.v20180908-M14

.PHONY: all build build-nocache

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .
