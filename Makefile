.PHONY: lint

lint\:fix:
	stylua .
lint:
	stylua --check .
	luacheck . --std luajit --globals vim --max-line-length 150 --no-config
	@LUA_LS=$$(which lua-language-server 2>/dev/null || echo "$$HOME/.local/share/nvim/mason/bin/lua-language-server"); \
		VIMRUNTIME=$$(nvim --clean --headless -c 'echo $$VIMRUNTIME' -c 'q' 2>&1) \
		$$LUA_LS --check lua --configpath "$$PWD/.luarc.json" --checklevel=Warning
install:
	pre-commit install
