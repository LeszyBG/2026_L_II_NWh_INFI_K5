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
	docker build -t hello-world-printerk5-2026 .

docker_run: docker_build
	docker run -d \
		--name hello-world-printerk5-2026 \
		-p 5000:5000 \
		hello-world-printer

docker_stop:
	docker stop hello-world-printerk5-2026 || true
	docker rm hello-world-printerk5-2026 || true

TAG=$(USERNAME)/hello-world-printerk5-2026
docker_push: docker_build
	@docker login --username $(USERNAME) --password "$(DOCKER_PASSWORD)"; \
	docker tag hello-world-printerk5-2026 $(TAG); \
