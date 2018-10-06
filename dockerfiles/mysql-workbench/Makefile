NAME = burnerdev/mysql-workbench
VERSION = 6.3.10

.PHONY: all build build-nocache

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .
