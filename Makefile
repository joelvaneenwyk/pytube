dev:
	uv sync -v

pipenv:
	uv sync -v

deploy-patch: clean requirements bumpversion-patch upload clean

deploy-minor: clean requirements bumpversion-minor upload clean

deploy-major: clean requirements bumpversion-major upload clean

requirements:
	uv lock

bumpversion-patch:
	uv run bumpversion patch
	git push
	git push --tags

bumpversion-minor:
	uv run bumpversion minor
	git push
	git push --tags

bumpversion-major:
	uv run bumpversion major
	git push
	git push --tags

upload:
	uv run python setup.py sdist bdist_wheel
	uv run twine upload dist/*

help:
	@echo "clean - remove all build, test, coverage and Python artifacts"
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "install - install the package to the active Python's site-packages"

ci:
	uv sync
	uv run flake8
	# uv run pytest --cov-report term-missing # --cov=humps
	uv run coverage run -m pytest

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +
	find . -name '*.DS_Store' -exec rm -f {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

install: clean
	uv run python setup.py install
