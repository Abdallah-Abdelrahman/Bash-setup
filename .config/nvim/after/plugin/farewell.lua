-- Close Neovim if NvimTree is the last open window/buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Check if the only window open is nvim-tree
    if vim.fn.winnr("$") == 1 then
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname:match("NvimTree_") then
        vim.cmd("quit")
      end
    end
  end
})
