# My neovim config

## Requirement

* git - clone this repo and clone plugins
* rg - for search file contents
* fd - for search files or directories
* node - for neovim extension
* python - for neovim extension
* [stylua] - format lua file
* [pre-commit] - static analysis before commit

[stylua]: https://github.com/JohnnyMorganz/StyLua
[pre-commit]: https://github.com/pre-commit/pre-commit

## Setup

```bash
cp -R ~/.config/nvim ~/.config/nvim_bak
git clone git@github.com:kang8/.vimrc.git ~/.config/nvim
```


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
