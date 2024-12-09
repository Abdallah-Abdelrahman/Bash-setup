local builtin = require('telescope.builtin')

-- leader key = empty space
vim.g.mapleader = ' '
-- tab navigation
vim.keymap.set('n', '<leader>t', '<cmd>tabn<CR>')

-- Mapping for lsp diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- Mapping for lazygit
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', {desc = 'lazygit'})
-- fold code keymaps
vim.keymap.set('n', '-', '<cmd>foldclose<CR>', {desc = 'fold close'})

-- make current buffer executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {desc = 'set buffer to be executable'})
-- :!nautilus %:p:h
vim.keymap.set('n', '<leader>of', '<cmd>!nautilus %:p:h<CR>', {desc = 'open directory in os'})
-- indent html
vim.keymap.set('n', '<leader>i', function()
	-- Save the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- vim.cmd([[%s/<[^>]*>/\r&\r/g]])
	vim.cmd('normal! gg=G')
	-- vim.cmd([[%g/^$/d]])
	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end, {desc = 'indent html'})

-- telescope
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
