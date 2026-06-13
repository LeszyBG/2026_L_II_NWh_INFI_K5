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

docker_build:
	docker build -t hello-world-printer-k5-2026 .

docker_run: docker_build
	docker run -d \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		hello-world-printer

docker_stop:
	docker stop hello-world-printer-dev || true
	docker rm hello-world-printer-dev || true

USERNAME ?= LeszyBG
IMAGE=hello-world-printer-k5-2026
TAG=$(USERNAME)/$(IMAGE):latest

docker_push: docker_build
	@echo "Logging in..."
	@docker login --username $(USERNAME)
	@docker tag hello-world-printer-k5-2026 $(TAG)
	@docker push $(TAG)
	@docker logout