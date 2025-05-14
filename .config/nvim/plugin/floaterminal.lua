local state = { buf = -1, win = -1 } -- Initialize state w/ invalid buffer and window IDs

local function open_floating_window(opts)
  opts = opts or {}
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.8)
  local height = math.floor(ui.height * 0.8)
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)
  local map = require('map')('')
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }
  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Create a command to open the floating terminal
vim.api.nvim_create_user_command('Floaterminal', function()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
  else
    state = open_floating_window({ buf = state.buf })
    if vim.bo[state.buf].buftype ~= 'terminal' then
      vim.cmd.term()
      vim.cmd("startinsert")
    end
  end
end, {})

-- Create a keymap to toggle the floating terminal
vim.keymap.set({ 't', 'n' }, '<leader>ft', '<cmd>Floaterminal<CR>', { noremap = true, desc = 'Toggle floating terminal' })
