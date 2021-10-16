" Vim-Plug donwload
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source ~/.config/nvim/plug/plug_list.vim
source ~/.config/nvim/core/basic.vim
source ~/.config/nvim/core/function.vim
source ~/.config/nvim/core/key_bindings.vim
source ~/.config/nvim/core/language_config.vim
source ~/.config/nvim/plug/plug_settings.vim
