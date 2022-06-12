local status, dashboard = pcall(require, 'dashboard')

if not status then
  vim.notify('Not found glepnir/dashboard-nvim')
  return
end

dashboard.hide_statusline = false

dashboard.custom_header = {
  [[ ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗   ]],
  [[ ██║ ██╔╝██╔══██╗████╗  ██║██╔════╝   ]],
  [[ █████╔╝ ███████║██╔██╗ ██║██║  ███╗  ]],
  [[ ██╔═██╗ ██╔══██║██║╚██╗██║██║   ██║  ]],
  [[ ██║  ██╗██║  ██║██║ ╚████║╚██████╔╝  ]],
  [[ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ]],
  [[                                      ]],
  [[                                      ]],
}

dashboard.custom_center = {
  {
    icon = '  ',
    desc = 'New file                            ',
    shortcut = ':enew',
    action = 'enew',
  },
  {
    icon = '  ',
    desc = 'Projects                          ',
    shortcut = 'SPC f p',
    action = 'Telescope projects',
  },
  {
    icon = '  ',
    desc = 'Recently files                    ',
    shortcut = 'SPC f o',
    action = 'Telescope oldfiles',
  },
  {
    icon = '  ',
    desc = 'Find file                 ',
    shortcut = 'SPC f f / SPC p',
    action = 'Telescope find_files',
  },
  {
    icon = '  ',
    desc = 'Find text                         ',
    shortcut = 'SPC f g',
    action = 'Telescope live_grep',
  },
  {
    icon = '  ',
    desc = 'Close neovim                         ',
    shortcut = ':qa!',
    action = 'qa!',
  },
}
