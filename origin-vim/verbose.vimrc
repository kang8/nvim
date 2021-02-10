" vim -u /path/verbose.vimrc

set nocompatible " compatible -> 兼容，取消 VIM 兼容模式
set t_RV= " VIM 遗留问题，详情请参考：http://bugs.debian.org/608242
set scrolloff=3 " 光标垂直移动时，距离顶部/底部的最小行数

set showcmd " 在屏幕右下方显示未完成的指令输入
set showmode " 在左下角显示当前模式
set nobackup " 取消文件备份。文件后缀名为 .backup
set noswapfile " 慎用！不创建交换文件，交换文件用于系统崩溃时的回复文件。文件后缀名为 .swp
set undofile " 保留撤销历史。文件后缀名为 .undo
set ruler " 在屏幕下方显示当前光标所在位置的行号和列号标尺
set number " 显示行号
set relativenumber " 显示相对行号
" 四种行号设置，如果光标现在在 15 行。上一行的绝对行号为 14，相对行号为 1
" set nonu nurnu 不显示行号
" set nu nornu 显示绝对行号
" set nonu rnu 显示相对行号，当前行为 0
" set nu rnu 显示相对行号，当前行为绝对行号

set hlsearch " 开启搜索高亮模式
set incsearch " 开启搜索增量模式。该模式会及时匹配当前输入的内容
set showmatch " 在输入成对括号时，自动跳转并高亮一下到匹配括号，然后跳回来
set matchtime=1 " 设置 showmatch 的时间为 100ms。默认为 500ms
set ignorecase " 搜索时忽略大小写
set smartcase " 开启智能搜索模式。如果搜索过程中输入了大写字母，VIM 会严格地进行大小写匹配

" 发生错误时，屏幕闪烁。这里关闭这个功能。该功能通常用于听觉障碍人士
set visualbell t_vb=
set novisualbell

set backspace=indent,eol,start " 使得 <BACKSPACE> 键可以回删缩进位置，行结束符，段首
set runtimepath=$VIMRUNTIME " 关闭用户自定义脚本，如果你使用插件，请注释这一行

syntax on " 开启语法高亮
filetype on " 开启文件类型检测
filetype indent on " 开启缩进规则，在文件类型检测生效后，根据文件类型加载不同的缩进规则


set expandtab " 将 <TAB> 转换为 <SPACE>
set smarttab " 开启 smarttab 后，在行首键入 <TAB>，会填充 shiftwidth 设定的数值，其他地方则填充 tabstop 设定的数值。如果取消 smarttab，任何地方键入 <TAB> 都会填充 tabstop 设定的数值
set autoindent " 开启自动缩进
set smartindent " 采用类似 C 语言的缩进风格
set shiftwidth=4 " 缩进对应的空格数
set tabstop=4 " <TAB> 字符所代表的空格数
set softtabstop=4 " 使用 <BACKSPACE> 删除时遇到 <TAB> 插入的空格，会直接删除设定的空格数，而不是一个一个删除
set wrap " 自动换行
set linebreak " 只有遇到空白符号才会换行。也就是说不会再单词内部换行

set list " 开启对特殊字符的回显
set listchars=eol:¬,tab:▸\ ,trail:·, " 自定义特殊字符的回显 trail 为空格

set encoding=utf-8 " 设置编码。unix like 可以自动检测系统的 locale，但是 windows 不会自动设置

set background=dark " 配色主题的色系 dark/light
colorscheme elfload " 配色主题的名称
set t_Co=256 " 启动 256 色

"----------------------------------------------------------------------

" 设置 leader 键
set mapleader=" "
set g:mapleader=" "

set shortmess=atI " 启动时不显示援助乌干达

autocmd filetype javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 " 根据文件类型设置特有的规则