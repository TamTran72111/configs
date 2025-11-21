vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')

-- Quick fix list
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'Next item on quick fix list' })
vim.keymap.set('n', '<M-k>', ':cprev<CR>', { desc = 'Previous item on quick fix list' })

vim.keymap.set('n', '<leader>dh', '<C-w>h<cmd>q<CR>', { desc = 'Close left window' })
vim.keymap.set('n', '<leader>dl', '<C-w>j<cmd>q<CR>', { desc = 'Close right window' })
vim.keymap.set('n', '<leader>dj', '<C-w>j<cmd>q<CR>', { desc = 'Close below window' })
vim.keymap.set('n', '<leader>dk', '<C-w>j<cmd>q<CR>', { desc = 'Close above window' })
