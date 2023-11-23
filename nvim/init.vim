scriptencoding utf-8
set encoding=utf-8

nmap <space> <leader>
vmap <space> <leader>

" Permanent undo
set undodir=~/.vimdid
set undofile

set nocompatible
"set nobackup
"set nowritebackup
"set noswapfile
"set history=50

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500
set completeopt=menuone,noinsert,noselect

set ruler
set relativenumber
set number
set signcolumn=yes

set showcmd

set incsearch
set nohlsearch
set nohlsearch
set ignorecase
set smartcase
set gdefault "global default for matching

set autowrite
set so=5

set mouse=a

set nojoinspaces " join J with no spaces

"------------------------------------------------------
"Title bar
set title
set titlestring=%F

"------------------------------------------------------
"Plugins
" After changing, make sure to :PlugInstall

call plug#begin(stdpath('data') . '/plugged')

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'lukas-reineke/lsp-format.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Fuzzy Finder
Plug '/home/hwchen/src/fzf/'
Plug 'junegunn/fzf.vim'
" Fuzzy finder for symbols/outline only (for now)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Editor
Plug 'airblade/vim-rooter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'ciaranm/securemodelines'
Plug 'phaazon/hop.nvim'
"Plug 'windwp/nvim-autopairs'

" Language support
Plug 'pest-parser/pest.vim'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'keith/swift.vim'
Plug 'ziglang/zig.vim'
Plug 'NoahTheDuke/vim-just'
Plug 'qnighy/lalrpop.vim',
Plug 'vmchale/dhall-vim'
Plug 'tetralux/odin.vim'
Plug 'itspriddle/vim-shellcheck'

" pyright installed from https://github.com/fannheyward/coc-pyright

" Theme
Plug 'EdenEast/nightfox.nvim', { 'branch': 'main' }

" External
Plug 'kassio/neoterm'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'voldikss/vim-floaterm'

call plug#end()

"------------------------------------------------------
" Color Scheme and terminal support
"syntax enable " not needed for neovim?
highlight clear SignColumn

" from kitty
" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''

set termguicolors
colo dayfox


"indent line disabled by default
let g:indentLine_enabled = 0

"------------------------------------------------------
"rooter
" only git, not makefile or other
let g:rooter_patterns = ['.git']


"------------------------------------------------------
"zig.vim
"let g:zig_fmt_autosave = 1

"------------------------------------------------------
"Files/Search
"Note, uses custom FZF_DEFAULT_COMMAND, fd, .fdignore to ignore correct files
"nnoremap <leader>o :Files<CR>
"nnoremap <leader>; :Buffers<CR>
"nnoremap <leader>g :Rg 
"toggles between buffers
nnoremap <space><space> <c-^>
let g:fzf_layout = { 'down' : '40%' }

"Search symbols using telescope/lsp
nnoremap <leader>l :Telescope lsp_document_symbols<CR>
nnoremap <leader>s :Telescope lsp_workspace_symbols<CR>

nnoremap <leader>o <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
" replaced with buffers picker
"nnoremap <leader>; <cmd>Telescope buffers<cr>
noremap <leader>; <cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>


"------------------------------------------------------
"Statusline

"hi clear StatusLine
"hi StatusLine ctermbg=black ctermfg=gray
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'dayfox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
    \ },
\ }

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"------------------------------------------------------
"Markdown
let g:vim_markdown_folding_disabled = 1

"------------------------------------------------------
"keyboard mappings

"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap jk <esc>

" use fzf now
"inoremap <leader>o <esc>:tabe 
"noremap <leader>o <esc>:tabe 

" no more tabs
"inoremap <leader>, <esc>:tabp<cr>
"noremap <leader>, <esc>:tabp<cr>

"inoremap <leader>. <esc>:tabn<cr>
"noremap <leader>. <esc>:tabn<cr>

inoremap <c-s> <esc>:w<cr>
noremap <c-s> <esc>:w<cr>

noremap <leader>i <esc>:IndentLinesToggle<cr>

highlight TabLineFill ctermfg=Black
highlight TabLineSel ctermbg=Black ctermfg=Gray
highlight TabLine ctermbg=Black ctermfg=DarkBlue

"splits

" use fzf now
"inoremap <c-o> <esc>:vsp 
"noremap <c-o> <esc>:vsp 

nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

inoremap <c-j> <c-w><c-j>
inoremap <c-k> <c-w><c-k>
inoremap <c-l> <c-w><c-l>
inoremap <c-h> <c-w><c-h>

"resizing splits: max height, width, fair
inoremap <leader>- <c-w>_
inoremap <leader>\ <c-w><bar>
inoremap <leader>= <c-w>=
nnoremap <leader>- <c-w>_
nnoremap <leader>\ <c-w><bar>
nnoremap <leader>= <c-w>=

" more split options
set splitbelow
set splitright


"------------------------------------------------------
"Indentation options (PEP8 style)
"Filetype specific indentation

"set textwidth=89   "lines longer than 79 columns broken
set shiftwidth=4   "operation >> indents 4 columns; << unindents 4
set tabstop=4      "a hard TAB displays as 8 columns
set expandtab      "insert spaces when hitting TABs
set softtabstop=4  "insert/delete 4 spaces when hitting TAB/BACKSPACE
set shiftround     "round indent to mulitple of 'shiftwidth'
set autoindent     "align the new line indent with previous line
set number         "show line numbers

" force markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" roc
autocmd BufNewFile,BufReadPost *.roc set filetype=roc

" tabs for odin dev only
" ** glob not working for some reason? Or is there some weird buffering going
" on? since json files in these repos are using tabs
autocmd BufNewFile,BufReadPost ~/odindev/odin/*.odin :setlocal noexpandtab
autocmd BufNewFile,BufReadPost ~/odindev/ols/*.odin :setlocal noexpandtab

" trailing whitespace

set list listchars=tab:»·,trail:·

" two space tabs for js
autocmd FileType javascript :setlocal sw=2 ts=2 noexpandtab autoindent"sts=2
autocmd FileType html :setlocal sw=2 ts=2 noexpandtab autoindent"sts=2
autocmd FileType css :setlocal sw=2 ts=2 noexpandtab autoindent"sts=2
autocmd FileType nix :setlocal sw=2 ts=2 autoindent"sts=2

" Change parens highlighting
hi MatchParen cterm=bold ctermbg=black ctermfg=yellow

" Python
autocmd FileType python set colorcolumn=0

"svelte
au! BufNewFile,BufRead *.svelte set ft=html

" Folding
"set foldmethod=syntax
"highlight Folded ctermbg=0
"highlight FoldColumn ctermbg=0
"set foldlevel=99

set rtp+=~/.fzf

"------------------------------------------------------
"Lints
"
" rust
let g:rustfmt_autosave = 1
let g:syntastic_rust_checkers = [] "use rust analyzer instead
"let g:rustfmt_options = 'config-path = /home/hwchen/projects/rust'

" system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

" neoterm, terminal
let g:neoterm_default_mod = 'botright'
" nnoremap <leader>t :Tnew<cr>
nnoremap <leader>t :!kitty --detach<cr><cr>

" Hop (github.com/phaazon/hop)
"nnoremap <leader>j :HopLineStart<cr>
nnoremap <leader>w :HopWord<cr>
nnoremap <leader>/ :HopPattern<cr>

lua << END

-- for logs: tail -f /home/hwchen/.local/state/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

require 'hop'.setup()
require("lsp-format").setup {
  rust = {
    exclude = { "rust-analyzer" }
  },
  zig = {
    exclude = { "zls" }
  },
  odin = {
    sync = true
  },
}

-- Used for tab-complete
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Used for tab-complete
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
      -- trigger completion using tab
      autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- Tab completion
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'g:', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'g;', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "rounded",
    },
  })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
        postfix = {
        enable = false,
        },
      },
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols",
            limit = 4096,
          },
        },
      },
    },
  },
  capabilities = capabilities,
}

lspconfig.zls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Make sure to `on_attach` https://stackoverflow.com/questions/70371671/can-pyright-lsp-navigate-to-different-module
lspconfig.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.ols.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.dhall_lsp_server.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- Roc
-- manual lsp startup, example at https://dx13.co.uk/articles/2023/04/24/neovim-lsp-without-plugins/
--local autocmd = vim.api.nvim_create_autocmd
--autocmd("FileType", {
--    pattern = "roc",
--    callback = function()
--        local root_dir = vim.fs.dirname(
--            vim.fs.find({ 'main.roc', '.git' }, { upward = true })[1]
--        )
--        local client = vim.lsp.start({
--            name = 'roc_ls',
--            cmd = { 'roc_ls' },
--            root_dir = root_dir,
--        })
--        vim.lsp.buf_attach_client(0, client)
--    end
--})

-- Telescope

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
require('telescope').load_extension('fzf')

-- treesitter

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- treesitter for roc
-- note that I also had to link the query files from ~/src/tree-sitter-roc/queries to ~/.config/nvim/queries/roc
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.roc = {
  install_info = {
    url = "~/src/tree-sitter-roc", -- local path or git repo
    files = {"src/parser.c", "src/scanner.cc"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "roc", -- if filetype does not match the parser name
}
vim.treesitter.language.register('roc', 'roc')

--require("nvim-autopairs").setup {}
--
---- If you want insert `(` after select function or method item
--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--local cmp = require('cmp')
--cmp.event:on(
--  'confirm_done',
--  cmp_autopairs.on_confirm_done()
--)

END
