-- bring `vim-plug` to lua
local Plug = vim.fn['plug#'];

--
---------- INSTALLING REMOTE PLUGINS ----------
--

vim.call('plug#begin');

-- Session Management
Plug 'rmagatti/auto-session'

-- UI Enhancements
Plug 'folke/tokyonight.nvim'  -- Dark theme
Plug 'ryanoasis/vim-devicons' -- Icons
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-tree/nvim-web-devicons'

-- LSP and Auto-completion
Plug 'neovim/nvim-lspconfig'
--Plug 'williamboman/mason.nvim'
--Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'   -- For vsnip users.
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'    -- For luasnip users.
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'SirVer/ultisnips'    -- For ultisnips users.
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'dcampos/nvim-snippy' -- For snippy users.
Plug 'dcampos/cmp-snippy'
Plug 'stevearc/conform.nvim'

-- Syntax Highlighting and Treesitter
Plug "SmiteshP/nvim-navic"

-- Git Integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'

-- Search and Navigation
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.6' });
Plug('preservim/nerdtree', { on = 'NERDTreeToggle' });

-- Code Utilities
Plug 'ap/vim-css-color'
Plug 'junegunn/vim-easy-align'
Plug 'honza/vim-snippets'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

-- Miscellaneous
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' });
Plug('rdnetto/YCM-Generator', { branch = 'stable' })
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = './install --all' });
Plug '~/my-prototype-plugin'

-- avante.nvim
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'MunifTanjim/nui.nvim'
Plug('yetone/avante.nvim', { branch = 'main', ['do'] = 'make', source = true });
---

-- plugins import ends here
vim.call('plug#end');

-->
------- IMPORT EXTERNAL PLUGINS ------------
-->

vim.o.winborder = 'rounded' -- set global window border style

require('lsp')              -- lsps starter

require('keybindings')      -- key bindings

require('gitsigns').setup() -- git changes bar tracker (green for addition, red for deletion)

---------------------------


-- source some vim config
vim.cmd("source ~/.vimrc");
