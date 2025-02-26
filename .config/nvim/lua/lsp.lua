require("mason").setup()
local lsp_mason = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

print("Setting up LSP", lspconfig)
lsp_mason.setup {
	ensure_installed = {
		'eslint',
		-- 'tsserver',
		'tailwindcss',
		'pyright',
		'clangd',
		'gopls',
	},
}

lsp_mason.setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup {
			capabilities = capabilities,
			on_attach = function()
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
				vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = 0 })
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
				vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = 0 })
			end,

		}
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	['lua_ls'] = function()
		lspconfig.lua_ls.setup {
      cmd = { "lua-language-server"},
      filetypes = { "lua" },
      root_markers = { '.luarc.json', 'luarc.jsonc' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          }
        }
      }
		}
	end,
	-- ['eslint'] = function()
	-- 	lspconfig.eslint.setup {
	-- 	TODO: override the default settings of config file
	-- 	instead of .eslintrc.json, use .eslintrc.js
	-- 	}
	-- 	end,
}
