-- bring `vim-plug` to lua
local Plug = vim.fn['plug#'];

--------- IMPORT CUSTOM PLUGINS --------------
--
-- script loads once mapping is defined
vim.api.nvim_set_keymap('v', '<leader>,', ":lua require('comment').comment_block()<CR>",
{noremap = true, silent = true, desc = 'comment block'})
-- defer script loading until mapping executed
vim.keymap.set('n', '<leader>,', function() require('comment').comment_line() end,
{noremap = true, silent = true, desc = 'comment one line'})

-- sql capitalize
vim.keymap.set('n', '<leader>q', function () require('sqlcap').capitalize() end,
{noremap = true, silent = true, desc = 'capitalize sql keywords'})



---------- IMPORTING REMOTE PLUGINS ----------
--
vim.call('plug#begin');

-- themesthemesthemesthemes
Plug 'folke/tokyonight.nvim'

-- neovim lsp config
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

-- auto completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip' -- For vsnip users.
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'-- For luasnip users.
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'SirVer/ultisnips'-- For ultisnips users.
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'dcampos/nvim-snippy'-- For snippy users.
Plug 'dcampos/cmp-snippy'

-- git decorations implemented
Plug 'lewis6991/gitsigns.nvim'

-- telescope for search
Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.6' });

Plug 'junegunn/vim-easy-align'

-- Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

-- Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

-- On-demand loading
Plug('preservim/nerdtree', { on = 'NERDTreeToggle'});
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' });

-- Using a non-default branch
Plug('rdnetto/YCM-Generator', { branch = 'stable' })

-- Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug('fatih/vim-go', { tag = '*' });

-- Plugin options
Plug('nsf/gocode', { tag = 'v.20150303', rtp = 'vim' });

-- Plugin outside ~/.vim/plugged with post-update hook
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = './install --all' });

-- Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

-- icons
Plug 'ryanoasis/vim-devicons'

-- status lines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- to disply airline sections
Plug 'tpope/vim-fugitive'

-- plugins import ends here
vim.call('plug#end');

-- LSP CONFIGURATION --
require('lsp')

-- AUTO-COMPLETION --
require('auto_cmp')

-- KEY BINDINGS --
require('keybindings')

require('gitsigns').setup()

-- source some vim config
vim.cmd("source ~/.vimrc");
