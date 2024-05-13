-- Run in the UIEnter because have a plugin using event is UIEnter in lazy.nvim
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local commands = vim.api.nvim_get_commands({ builtin = false })
    -- see: https://github.com/tpope/vim-git/blob/105fd5559bd9df3f1204ecdcac2a587614e1a4be/ftplugin/gitrebase.vim#L24
    local rebase_words = { 'Pick', 'Squash', 'Edit', 'Reword', 'Fixup', 'Drop' }

    for command, _ in pairs(commands) do
      for _, rebase_word in pairs(rebase_words) do
        if vim.startswith(command, string.sub(rebase_word, 1, 1)) and command ~= rebase_word then
          vim.api.nvim_del_user_command(command)
        end
      end
    end
  end,
})
