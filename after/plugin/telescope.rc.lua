local status, telescope = pcall(require, "telescope")

if not status then
  vim.notify("Not found telescope.nvim")
  return
end

vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fe", "<cmd>Telescope env<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", {noremap = true, silent = true })

telescope.setup{

}

-- telescope extensions
pcall(telescope.load_extension, "env")
