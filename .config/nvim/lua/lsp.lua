-- Add the same capabilities to ALL server configurations.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local telescope_builtin = require("telescope.builtin")
local navic = require("nvim-navic")
local lsp_mason = require("mason-lspconfig")

require("mason").setup()

lsp_mason.setup {
  ensure_installed = {
    'eslint',
    --'tsserver',
    'tailwindcss',
    'clangd',
    'gopls',
    --'ruff',
    'pyright'
  },
}

local on_attach = function(client, bufnr)
  if client.name == 'gopls' then
    -- Ensure omnifunc is not set to vim-go's completer when gopls is active.
    -- This explicitly unsets omnifunc for the current buffer.
    vim.bo.omnifunc = ''
    --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', '')
  end
  if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
  local map = require('map')('lsp')
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
  map({
    key = "K",
    action = vim.lsp.buf.hover,
    desc = "Show documentation",
  })
  map({
    key = "<C-k>",
    action = vim.lsp.buf.signature_help,
    desc = "Show signature help",
  })
end

vim.lsp.config("*", {
  capabilities = capabilities, --vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
});
