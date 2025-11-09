# Neovim Configuration

A modern, modular Neovim setup leveraging Neovim 0.11+ native LSP architecture with auto-discovery of language servers.

## Features

- **Native LSP**: Uses Neovim's built-in LSP client
- **Auto-discovery**: LSP servers are automatically loaded from `/lsp/*.lua` configs
- **Modular**: Each language server has its own dedicated config file
- **Pre-configured servers**: TypeScript, Python, Go, Rust, C/C++, Lua, Tailwind CSS
- **Auto-completion**: Via `nvim-cmp` with LSP integration
- **Telescope**: Fuzzy finding for files, references, and symbols
- **Git integration**: Gitsigns, Fugitive, and LazyGit support
- **AI assistance**: Copilot and Avante.nvim integration

## Structure

```
~/.config/nvim/
├── after
│   └── plugin
│       ├── colors.lua
│       ├── farewell.lua
│       ├── floaterminal.lua
│       └── remove_trailing.lua
├── init.lua
├── lsp
│   ├── clangd.lua
│   ├── eslint.lua
│   ├── gopls.lua
│   ├── lua_ls.lua
│   ├── pyright.lua
│   ├── ruff.lua
│   ├── tailwindcss.lua
│   └── ts_ls.lua
├── lua
│   ├── comment.lua
│   ├── format.lua
│   ├── keybindings.lua
│   ├── lsp.lua
│   ├── map.lua
│   ├── on_save.lua
│   └── sqlcap.lua
├── pack
│   └── github
│       └── start
│           └── copilot.vim
│               ├── autoload
│               │   ├── copilot
│               │   │   ├── client.vim
│               │   │   ├── handlers.vim
│               │   │   ├── job.vim
│               │   │   ├── logger.vim
│               │   │   ├── panel.vim
│               │   │   ├── util.vim
│               │   │   └── version.vim
│               │   └── copilot.vim
│               ├── dist
│               │   ├── compiled
│               │   │   ├── darwin
│               │   │   │   ├── arm64
│               │   │   │   │   └── kerberos.node
│               │   │   │   └── x64
│               │   │   │       └── kerberos.node
│               │   │   ├── linux
│               │   │   │   ├── arm64
│               │   │   │   │   └── kerberos.node
│               │   │   │   └── x64
│               │   │   │       └── kerberos.node
│               │   │   └── win32
│               │   │       └── x64
│               │   │           └── kerberos.node
│               │   ├── crypt32.node
│               │   ├── language-server.js
│               │   ├── language-server.js.map
│               │   ├── resources
│               │   │   ├── cl100k_base.tiktoken.noindex
│               │   │   └── o200k_base.tiktoken.noindex
│               │   ├── tree-sitter-go.wasm
│               │   ├── tree-sitter-javascript.wasm
│               │   ├── tree-sitter-python.wasm
│               │   ├── tree-sitter-ruby.wasm
│               │   ├── tree-sitter-tsx.wasm
│               │   ├── tree-sitter-typescript.wasm
│               │   └── tree-sitter.wasm
│               ├── doc
│               │   ├── copilot.txt
│               │   └── tags
│               ├── LICENSE.md
│               ├── lua
│               │   └── _copilot.lua
│               ├── plugin
│               │   └── copilot.vim
│               ├── README.md
│               ├── SECURITY.md
│               └── syntax
│                   ├── copilotlog.vim
│                   └── copilot.vim
├── plugin
│   ├── auto_cmp.lua
│   ├── auto_session.lua
│   ├── avante.lua
│   ├── conform.lua
│   ├── getsigns.lua
│   ├── navic.lua
│   └── nvim-tree.lua
└── README.md
```

## Prerequisites

- **Neovim 0.11+** (for native LSP config auto-loading)
- **Node.js** (for TypeScript, Tailwind, ESLint servers)
- **Python 3** (for Python language servers)
- **Go** (for gopls)
- **Git**

## Installation

### 1. Clone this config

```bash
git clone <your-repo-url> ~/.config/nvim
```

### 2. Install LSP servers

Since this config doesn't use Mason, install language servers manually:

```bash
# TypeScript/JavaScript
npm install -g typescript typescript-language-server

# Tailwind CSS
npm install -g @tailwindcss/language-server

# ESLint (optional, for linting)
npm install -g vscode-langservers-extracted

# Python
pip install --user pyright ruff
# Or: pipx install pyright && pipx install ruff

# Go
go install golang.org/x/tools/gopls@latest

# Lua
# Install via your package manager, e.g.:
# sudo apt install lua-language-server
# brew install lua-language-server

# C/C++ (clangd)
# sudo apt install clangd
# brew install llvm
```

### 3. Install plugins

Open Neovim and run:

```vim
:PlugInstall
```

### 4. Restart Neovim

LSP servers will auto-attach when you open files of their filetype.

## Adding a New LSP Server

1. **Install the LSP server binary** (npm, pip, go install, etc.)
2. **Create a config file**: `/home/fola/.config/nvim/lsp/<server_name>.lua`
3. **Return a config table**:

```lua
return {
  cmd = { 'your-language-server', 'args' },
  filetypes = { 'yourfiletype' },
  root_markers = { '.git', 'package.json' },
  settings = {
    -- server-specific settings
  },
}
```

4. **Restart Neovim** — the server is automatically discovered and enabled!

## Key Bindings (LSP)

All LSP bindings are buffer-local and only active when an LSP is attached:

| Key           | Action                  |
|---------------|-------------------------|
| `gd`          | Go to definition        |
| `gj`          | Find references         |
| `gi`          | Go to implementation    |
| `gt`          | Go to type definition   |
| `K`           | Show hover docs         |
| `<leader>rn`  | Rename symbol           |
| `<leader>ca`  | Code action             |
| `<leader>f`   | Format buffer           |
| `<C-k>`       | Signature help          |

## Troubleshooting

### LSP server not starting

1. **Check if the server is installed**:
   ```bash
   which typescript-language-server
   which pyright-langserver
   ```

2. **Verify PATH in Neovim**:
   ```vim
   :lua print(vim.env.PATH)
   ```

3. **Check LSP status**:
   ```vim
   :LspInfo
   ```

4. **View LSP logs**:
   ```vim
   :lua vim.cmd.edit(vim.lsp.get_log_path())
   ```


## Resources

- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Language Server Protocol](https://microsoft.github.io/language-server-protocol/)

## License

MIT
