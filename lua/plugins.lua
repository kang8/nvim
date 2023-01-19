local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd([[ packadd packer.nvim ]])

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup({
  function(use)
    -- Packer can manage itself
    use({ 'wbthomason/packer.nvim', events = 'VimEnter' })
    --------------------- colorschemes --------------------
    use('folke/tokyonight.nvim')

    --------------------- treesitter ----------------------
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'nvim-treesitter/playground' })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
    use({ 'nvim-treesitter/nvim-treesitter-context' })

    --------------------- telescope -----------------------
    use({ 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' })
    use({ 'LinArcX/telescope-env.nvim' })
    use({ 'debugloop/telescope-undo.nvim' })

    --------------------- other -----------------------
    use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })

    use({ 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' })

    use({ 'ahmedkhalf/project.nvim' })
    use({ 'glepnir/dashboard-nvim' })

    use({ 'dstein64/vim-startuptime' })

    use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })

    use({ 'windwp/nvim-autopairs' })
    use({ 'windwp/nvim-ts-autotag' })

    use({ 'numToStr/Comment.nvim' })

    use({ '907th/vim-auto-save' }) -- 自动保存
    use({ 'kang8/smartim' }) -- macos 自动切换输入法
    use({ 'junegunn/vim-easy-align' }) -- 对齐
    use({ 'lambdalisue/suda.vim' }) -- 提供 sudo
    use({ 'tpope/vim-surround' }) -- 在 vim 中对括号/引号等环绕字符非常简单快速的修改
    use({ 'RRethy/vim-illuminate' })
    use({ -- 使用浏览器预览 markdown
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
    })
    use({ 'svban/YankAssassin.vim', event = { 'BufRead', 'BufNewFile' } }) -- yank 时不移动光标
    use({ 'andymass/vim-matchup', event = { 'BufRead', 'BufNewFile' } }) -- 增强 %
    use({ 'fladson/vim-kitty' }) -- syntax highlighting for Kitty config files
    use({ 'unblevable/quick-scope' })
    use({ 'lewis6991/spellsitter.nvim' }) -- spell check
    use({ 'ii14/emmylua-nvim', ft = 'lua' }) -- lua completion
    use({ 'echasnovski/mini.nvim' })
    use({ 'folke/noice.nvim', requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } })
    use({ 'simrat39/symbols-outline.nvim' })
    use({ 'nacro90/numb.nvim' })
    use({ 'felipec/vim-sanegx' })

    --------------------- Git -----------------------------
    use({ 'lewis6991/gitsigns.nvim' })
    use({ 'tpope/vim-fugitive', require = { 'tpope/vim-git', 'tpope/vim-rhubarb' } })
    use({ 'ruanyl/vim-gh-line' }) -- open specified line in github

    --------------------- LSP -----------------------------
    use({ 'neovim/nvim-lspconfig' })
    use({ 'williamboman/mason.nvim' })
    use({ 'williamboman/mason-lspconfig.nvim' })
    -- ui
    use({ 'glepnir/lspsaga.nvim' })
    -- other
    use({ 'folke/neodev.nvim' })
    use({ 'b0o/schemastore.nvim' })

    --------------------- cmp -> code complete ------------
    use({ 'hrsh7th/nvim-cmp' })
    -- snippet
    use({ 'L3MON4D3/LuaSnip' })
    use({ 'saadparwaiz1/cmp_luasnip' })
    -- source
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-cmdline' })
    -- Common programming lanuage code snippet
    use({ 'rafamadriz/friendly-snippets' })
    -- ui
    use({ 'onsails/lspkind-nvim' })

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})
