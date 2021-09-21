local current_file_name = vim.api.nvim_eval('expand("<sfile>:p")')
local system_name = 'unknown'
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
end

-- Mapleader 
vim.g.mapleader = " " -- space

-- Windows compatable commands for Ctrl+C and Ctrl+V
vim.cmd("source $VIMRUNTIME/mswin.vim")

-- Quick settings open and reload
-- vim.cmd([[
--   augroup vimrc
--     autocmd!
--     exec "autocmd BufWritePost " . expand("<sfile>:t") . " source $MYVIMRC"
--   augroup end
-- ]])
vim.cmd('nnoremap <leader>` :e ' .. current_file_name .. '<CR>')

-- Sensible Bindings
-- Unmap Q
vim.cmd("nmap Q <Nop>")
-- ESC to leave terminal
vim.cmd("tnoremap <ESC> <C-\\><C-n>")

-- Opening files and directories from current path
vim.cmd('nnoremap <leader>e :e <C-R>=expand("%:p:h")."/"<cr>')
vim.cmd('nnoremap <leader>cd :cd <C-R>=expand("%:p:h")."/"<cr>')

-- Settings
-- Default Shell (for terminal)
vim.o.shell = 'pwsh' -- Powershell
-- Display line numberse
vim.o.number = true
-- Display signs (debugging, etc) shared in the number column
vim.o.signcolumn = 'number' -- TODO: Look into why lsp overwrites this to auto?
-- Case settings
vim.o.ignorecase = true
vim.o.smartcase = true
-- Incremental search
vim.incsearch = true
-- Completion options
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.o.completeopt = 'menuone,noinsert,noselect'
-- Expand all tabs by default
vim.o.expandtab = true
-- Allow mouse to be used in all modes
vim.o.mouse = 'a'
-- Trigger CursorHold event in normal mode after no keys are pressed
vim.o.updatetime = 550
-- Set Vim to automatically read in modified files
vim.o.autoread = true

vim.cmd([[
        augroup neovimrc
            " Remove all neovimrc autocmds (useful when resourcing)
            autocmd!
            " Remove line numbers from terminal buffers
            autocmd TermOpen * setlocal nonumber
            autocmd TermOpen * setlocal norelativenumber
            " Update any changed files in buffers
            autocmd BufLeave * if &buftype ==# 'terminal' | checktime | endif
        augroup END
]])

-- Plugins
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colourscheme
  use 'marko-cerovac/material.nvim'

  -- F3 to toggle current window to max size and back
  use 'szw/vim-maximizer'

  -- gc to comment out lines
  use 'tpope/vim-commentary'

  -- cs to change surrounding text
  use 'tpope/vim-surround'

  -- Autocompletion
  -- Neovim Language Server Protocol Configuations using builtin LSP
  use 'neovim/nvim-lspconfig'
  -- Autoformatting?
  -- Use sbdchd/neoformat?
  
  -- Better syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  -- Add configuration for better text objects (in function, in class, etc) ?
  -- use { 'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat', run = ':TSUpdate' }

  -- Fuzzy Finding (files, buffers, etc)
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }

  -- Debug Adapter Protocol
  -- TODO: Configure for various languages (.e.g lldb)
  use 'mfussenegger/nvim-dap'
  -- Telescope prompt for debugging information (dap => commands configurations list_breakboints variables frames)
  use { 'nvim-telescope/telescope-dap.nvim', requires = { {'nvim-telescope/telescope.nvim'} } }

  -- Add font-based icons (from supported fonts re: nerdfonts.com)
  use 'kyazdani42/nvim-web-devicons'

  -- Popup completion engine
  use {
    "hrsh7th/nvim-cmp", -- base engine
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/vim-vsnip", snippets?
    }
  }

  -- Status line
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
end)

-- Auto-recompile plugins after upting this file
-- TODO: Verify this works
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

-- Set Colourscheme
vim.g.material_style = "darker"
vim.cmd('colorscheme material')

-- Setup Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

-- Startup status line
require('lualine').setup({
  options = {
    theme = "material"
  },
  -- NB: Putting nvim_treesitter:#statusline in results in sometimes text that is too large to fit
})

-- Telescope settings and bindings
vim.cmd('nnoremap <leader>ff <cmd>Telescope find_files<cr>')
vim.cmd('nnoremap <leader>fo <cmd>Telescope file_browser<cr>')
vim.cmd('nnoremap <leader>fg <cmd>Telescope live_grep<cr>')
vim.cmd('nnoremap <leader>fb <cmd>Telescope buffers<cr>')
vim.cmd('nnoremap <leader>fh <cmd>Telescope help_tags<cr>')

-- Langauge Server settings and bindings
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- *Must* put the on_attach callback in each setup() call for each LSP server for these to take effect
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- vim.cmd('nnoremap gt <cmd>Telescope lsp_type_definitions<cr>') -- type definitions?
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --- Telescope lsp
  buf_set_keymap('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Rust
nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
})

-- Lua
-- TODO/NB: This might only make sense if this lua configuration file is where
-- it's supposed to be with the rest of the lua configurations for neovim
-- Maybe symlink?
--
-- local sumneko_root_path = 'C:/Projects/lua-language-server'
-- local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- nvim_lsp.sumneko_lua.setup {
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

-- Debug Adapter Settings
local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''}) -- TODO: Fix this
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapBreakpointRejected', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='Cursor', linehl='', numhl=''})

vim.cmd('nnoremap <F5> <cmd>lua require("dap").continue()<CR>')
vim.cmd('nnoremap <F9> <cmd>lua require("dap").toggle_breakpoint()<CR>')
vim.cmd('nnoremap <silent> <F10> :lua require("dap").step_over()<CR>')
vim.cmd('nnoremap <silent> <F11> :lua require("dap").step_into()<CR>')
vim.cmd('nnoremap <silent> <F12> :lua require("dap").step_out()<CR>')
vim.cmd('nnoremap <silent> <leader>B :lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.cmd('nnoremap <silent> <leader>lp :lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
vim.cmd('nnoremap <silent> <leader>dr :lua require("dap").repl.open()<CR>')
vim.cmd('nnoremap <silent> <leader>dl :lua require("dap").run_last()<CR>')

--- Telescope Debug Extension (DAP)
require('telescope').load_extension('dap')

-- TODO: Disable this when things are fixed
dap.set_log_level('TRACE')

local lldb_executable = 'C:/Program Files/LLVM/bin/lldb-vscode.exe'

-- TODO: Set :help dap.set-log-level
dap.adapters.lldb = {
  type = 'executable',
  command = lldb_executable,
  name = "lldb",
}

-- Simple rust debugging configuration
-- TODO: Expand out configurations into separate/project-related files?
dap.configurations.rust = {
  {
    name = "Launch Rust",
    type = "lldb",
    request = "launch",
    -- program = "C:/Projects/rust/rlox/target/debug/rlox.exe",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    -- cwd = vim.fn.getcwd(),
    -- stopOnEntry = false,
    stopOnEntry = true,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

-- Completion Engine Settings
local cmp = require('cmp')
cmp.setup {
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
}
