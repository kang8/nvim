# My neovim config

## Requirement

* git - clone this repo and clone plugins
* rg - for search file contents
* fd - for search files or directories
* node - for neovim extension
* python - for neovim extension
* [stylua] - format lua file
* [luacheck] - A tool for linting and static analysis of Lua code
* [pre-commit] - static analysis before commit

[stylua]: https://github.com/JohnnyMorganz/StyLua
[luacheck]: https://github.com/lunarmodules/luacheck
[pre-commit]: https://github.com/pre-commit/pre-commit

## Setup

TODO


### Setup pre-commit

```bash
make install
```

### Install python and node extension

```bash
# python
pip install neovim
# node
npm install -g neovim
```


## Detail configuration

### keymaps

* `<C-c>`, Close other buffers
vim-illuminate
* `[[`, Next reference
* `]]`, Prev reference
