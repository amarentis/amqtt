.SHELLFLAGS = -e -c
.ONESHELL:
.SILENT:

bootstrap:
	python3 -m venv .venv
	. .venv/bin/activate
	python -m pip install poetry
	poetry install --only main

bootstraptest: bootstrap
	. .venv/bin/activate
	poetry install 	

amqtt:
	. .venv/bin/activate
	echo "starting amqtt"
	poetry install	
	poetry run amqtt

amqtt_pub:
	. .venv/bin/activate
	poetry install 
	poetry run amqtt_pub

amqtt_sub:
	. .venv/bin/activate
	poetry install 
	poetry run amqtt_sub

test:
	. .venv/bin/activate
	poetry run pytest

testcov:
	. .venv/bin/activate
	poetry run pytest --cov
	poetry run flake8 tests/ amqtt/ --count --statistics --show-source

clean:
	find . -name "__pycache__" -type d -prune -exec rm -rf '{}' +
	find . -name "*.pyc" -type f -prune -exec rm -rf '{}' +

cleantest: clean
	find . -name ".venv" -type d -prune -exec rm -rf '{}' +