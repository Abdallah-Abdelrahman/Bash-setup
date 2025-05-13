-- Add the same capabilities to ALL server configurations.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local telescope_builtin = require("telescope.builtin")

require("mason").setup()
local lsp_mason = require("mason-lspconfig")
--local lspconfig = require('lspconfig')

lsp_mason.setup {
  ensure_installed = {
    'eslint',
    --'tsserver',
    'tailwindcss',
    'pyright',
    'clangd',
    'gopls',
  },
}

local on_attach = function(_client, _bufnr)
  local map = require('map')('lsp')
  map({
    desc = "Rename",
    key = "<leader>rn",
    action = vim.lsp.buf.rename,
  })
  map({
    desc = "Code action",
    key = "<leader>ca",
    action = vim.lsp.buf.code_action,
  })
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
    desc = "Format buffer",
    key = "<leader>f",
    action = vim.lsp.buf.format,
  })
end

vim.lsp.config("*", {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
});
