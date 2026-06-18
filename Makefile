.PHONY: deps lint test run docker_build docker_run docker_stop

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. pytest --verbose -s

run:
	python hello_world/main.py


docker_run: docker_build
	docker run -d \
		--name hello-world-printer-k5-2026 \
		-p 5000:5000 \
		hello-world-printer

docker_stop:
	docker stop hello-world-printer-k5-2026 || true
	docker rm hello-world-printer-k5-2026 || true
	
USERNAME ?= leszybg
IMAGE_NAME = hello-world-printer-k5-2026
TAG ?= latest
FULL_IMAGE=$(USERNAME)/$(IMAGE_NAME)

docker_build:
	docker build -t $(FULL_IMAGE):$(TAG) .

docker_push: docker_build
	docker push $(FULL_IMAGE):$(TAG)
