vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = '80'

vim.wo.signcolumn = 'yes'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', {clear = true}),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing spaces on save',
  group = vim.api.nvim_create_augroup('remove-trailing-spaces', {clear = true}),
  command = ':%s/\\s\\+$//e',
})

