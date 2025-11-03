-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    if vim.bo.modifiable then
      vim.cmd([[keeppatterns %s/\s\+$//e]])
    end
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})
