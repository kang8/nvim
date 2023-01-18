local status, saga = pcall(require, 'lspsaga')
if not status then
  vim.notify('Not found glepnir/lspsaga.nvim', vim.log.levels.WARN)
  return
end

saga.setup({
  server_filetype_map = {
    typescript = 'typescript',
  },
  rename = {
    in_select = false,
    whole_project = false,
  },
  lightbulb = {
    enable = false,
  },
})

local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set({ 'n', 't' }, '<F14>', '<Cmd>Lspsaga term_toggle<CR>', opts)

    vim.cmd([[ command! Rename :Lspsaga rename ]])
    vim.cmd([[ command! Format lua vim.lsp.buf.format({ async = true }) ]])
  end,
})
