.PHONY: deps lint test run

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
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer
docker_stop:
	docker stop hello-world-printer-dev || true
	docker rm hello-world-printer-dev || truedocker_run: docker_build 

docker run \ 

       --name hello-world-printer-dev \ 

   -p 5000:5000 \ 

   -d hello-world-printer 