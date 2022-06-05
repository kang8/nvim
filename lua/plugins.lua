require("packer").startup({
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    --------------------- colorschemes --------------------
    use 'gruvbox-community/gruvbox'
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
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
