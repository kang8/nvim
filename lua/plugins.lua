require('packer').startup({
  function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    --------------------- colorschemes --------------------
    use('gruvbox-community/gruvbox')
    --------------------- plugins -------------------------
    use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })

    use({ 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' })

    use({ 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' })
    use({ 'arkav/lualine-lsp-progress' })

    use({ 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' })
    use({ 'LinArcX/telescope-env.nvim' })
    use({ 'ahmedkhalf/project.nvim' })

    use({ 'glepnir/dashboard-nvim' })

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    use({ 'dstein64/vim-startuptime' })

    use({ 'lukas-reineke/indent-blankline.nvim' })

    use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })

    use({ 'windwp/nvim-autopairs' })

    use({ 'numToStr/Comment.nvim' })

    --------------------- LSP -----------------------------
    use({ 'neovim/nvim-lspconfig' })
    use({ 'williamboman/nvim-lsp-installer' })
    -- lanuage
    use({ 'b0o/schemastore.nvim' }) -- json
    use({ 'simrat39/rust-tools.nvim' }) -- rust

    --------------------- cmp -> code complete ------------
    use({ 'hrsh7th/nvim-cmp' })
    -- snippet
    use({ 'hrsh7th/vim-vsnip' })
    -- source
    use({ 'hrsh7th/cmp-vsnip' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-cmdline' })
    -- Common programming lanuage code snippet
    use({ 'rafamadriz/friendly-snippets' })
    -- ui
    use({ 'onsails/lspkind-nvim' })
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})

-- 每次保存 plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd WinLeave plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
