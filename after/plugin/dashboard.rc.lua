if not vim.g.loaded_dashboard then
  vim.notify("Not found dashboard.nvim")
  return
end

vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
  a = { description = { "  Projects                    SPC f p" }, command = "Telescope projects" },
  b = { description = { "  Recently files              SPC f o" }, command = "Telescope oldfiles" },
  g = { description = { "  Find file           SPC f f / SPC p" }, command = 'Telescope find_files'},
  h = { description = { "  Find text                   SPC f g" }, command = 'Telescope live_grep'},
}

vim.g.dashboard_custom_header = {
  [[ ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗   ]],
  [[ ██║ ██╔╝██╔══██╗████╗  ██║██╔════╝   ]],
  [[ █████╔╝ ███████║██╔██╗ ██║██║  ███╗  ]],
  [[ ██╔═██╗ ██╔══██║██║╚██╗██║██║   ██║  ]],
  [[ ██║  ██╗██║  ██║██║ ╚████║╚██████╔╝  ]],
  [[ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ]],
}
