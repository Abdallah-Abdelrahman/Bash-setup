-- Add the same capabilities to ALL server configurations.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local telescope_builtin = require("telescope.builtin")
local navic = require("nvim-navic")

local on_attach = function(client, bufnr)

  if client.name == 'gopls' then
    -- vim.bo.omnifunc = ''
  end
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  local map = require('map')('lsp')
  map({
    desc = "Go to definition",
    key = "gd",
    action = vim.lsp.buf.definition,
  })
  map({
    desc = "Find references",
    key = "gj",
    action = telescope_builtin.lsp_references,
  })
  map({
    desc = "Go to implementation",
    key = "gi",
    action = telescope_builtin.lsp_implementations,
  })
  map({
    desc = "Go to type definition",
    key = "gt",
    action = vim.lsp.buf.type_definition,
  })
  map({
    key = "K",
    action = function()
      -- Show documentation in a floating window
      vim.lsp.buf.hover({ border = "rounded", max_width = 120 })
    end,
    desc = "Show documentation",
  })
  map({
    desc = "Rename variable",
    key = "<leader>rn",
    action = vim.lsp.buf.rename,
  })
  map({
    desc = "Code action",
    key = "<leader>ca",
    action = vim.lsp.buf.code_action,
  })
  map({
    desc = "Format buffer",
    key = "<leader>f",
    action = function()
      vim.lsp.buf.format()
    end,
  })
  map({
    key = "<C-k>",
    action = vim.lsp.buf.signature_help,
    desc = "Show signature help",
  })
end

-- Set global defaults for ALL LSP servers
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Auto-discover and enable all LSP servers from /lsp/*.lua
local lsp_dir = vim.fn.stdpath('config') .. '/lsp'
local files = vim.fn.readdir(lsp_dir)
local servers = {}

for _, filename in ipairs(files) do
  if filename:match('%.lua$') then
    local server_name = filename:match('(.+)%.lua$')
    table.insert(servers, server_name)
  end
end

vim.lsp.enable(servers)
