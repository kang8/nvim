.PHONY: lint

lint\:fix:
	stylua .
lint:
	stylua --check .
	luacheck . --std luajit --globals vim --max-line-length 150 --no-config
install:
	pre-commit install
