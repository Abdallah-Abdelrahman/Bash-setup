-- leader key
vim.g.mapleader = ' '
-- tab navigation
vim.keymap.set('n', '<leader>t', '<cmd>tabn<CR>')

-- Mapping for lsp diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- fold code keymaps
vim.keymap.set('n', '-', '<cmd>foldclose<CR>', {desc = 'fold close'})

-- make current buffer executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {desc = 'set buffer to be executable'})
-- :!nautilus %:p:h
vim.keymap.set('n', '<leader>ex', '<cmd>!nautilus %:p:h<CR>', {desc = 'open directory in os'})
