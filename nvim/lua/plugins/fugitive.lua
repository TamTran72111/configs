return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = '[G]it [B]lame' })
    vim.keymap.set('n', '<leader>gl', ':Git difftool<CR>', { desc = '[G]it diff [L]ist' })
    vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = '[G]it [d]iff split' })
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
  end,
}
