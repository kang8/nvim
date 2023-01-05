.PHONY: lint

lint\:fix:
	stylua .
lint:
	stylua --check .
install:
	pre-commit install
