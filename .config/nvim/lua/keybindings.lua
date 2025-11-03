local builtin = require('telescope.builtin')

vim.opt.laststatus = 3 -- for avante.nvim

vim.opt.swapfile = false -- disable swap files

-- Disable vim-go's default `K` mapping for documentation
vim.g.go_doc_keywordprg_enabled = 0

-- leader key = empty space
vim.g.mapleader = ' '
--
-- relative line number
vim.opt.relativenumber = true
vim.opt.number = true

-- paste always from the yank register instead of the default register
vim.keymap.set('n', '<leader>p', '"0p', { desc = 'past from the last yanded text' })
vim.keymap.set('n', '<leader>P', '"0P', { desc = 'past from the last yanded text' })

-- terminal mode toggle
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { noremap = true, desc = 'toggle terminal' })

-- tab navigation
vim.keymap.set('n', '<leader>t', '<cmd>tabn<CR>')

-- Mapping for lsp diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- Mapping for lazygit
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', { desc = 'lazygit' })
-- fold code keymaps
vim.keymap.set('n', '-', '<cmd>foldclose<CR>', { desc = 'fold close' })

-- make current buffer executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'set buffer to be executable' })
-- :!nautilus %:p:h
vim.keymap.set('n', '<leader>of', '<cmd>!nautilus %:p:h<CR>', { desc = 'open directory in os' })
-- indent html
vim.keymap.set('n', '<leader>i', function()
  -- Save the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- vim.cmd([[%s/<[^>]*>/\r&\r/g]])
  vim.cmd('normal! gg=G')
  -- vim.cmd([[%g/^$/d]])
  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { desc = 'indent html' })

-- telescope
vim.keymap.set('n', '<leader>sf', function()
    builtin.find_files({
      -- hidden = true, -- Include hidden files
      -- no_ignore = true, -- Ignore .gitignore
      -- follow = true,    -- Follow symlinks
    })
  end,
  { desc = 'find files including hidden files' }
)
vim.keymap.set('n', '<leader>sg', function()
  builtin.live_grep({
    -- additional_args = function(opts)
    --   return { '--hidden', '--no-ignore' } -- Include hidden files and ignore .gitignore
    -- end,
  })
end, { desc = "Live grep (including hidden files)" })
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<C-s>g', builtin.git_files, { desc = 'search git files only' })

vim.keymap.set('n', '<leader>vy', function()
  vim.cmd(":%y")
end, { desc = 'yank all buffer content' })

vim.keymap.set('n', '<leader>vd', function()
  vim.cmd(":%d")
end, { desc = 'delete all buffer content' })

vim.keymap.set('n', '<C-a>', function()
  vim.cmd("normal! ggVG")
end, { desc = 'select all buffer content' })
