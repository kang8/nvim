if vim.g.vscode then
  local vscode = require('vscode')

  vim.keymap.set('n', 'gd', function()
    vscode.action('editor.action.revealDefinition')
  end)

  vim.keymap.set('n', 'gg', function()
    vscode.action('cursorTop')
  end)
end
