require("mason").setup()
local lsp_mason = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()


lsp_mason.setup {
	ensure_installed = {
		'eslint',
		'tsserver',
		'tailwindcss',
		'pyright'
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
	-- ['pylsp'] = function()
	-- 	lspconfig.pylsp.setup {
	-- 		settings = {
	-- 			pylsp = {
	-- 				plugins = {
	-- 					pylint = { enabled = true, executable = 'pylint', }
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- end,
}
