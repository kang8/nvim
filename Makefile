.PHONY: lint

lint\:fix:
	stylua .
lint:
	stylua --check .

