scriptencoding utf-8
set encoding=utf-8

" flickering on startup https://github.com/neovim/neovim/issues/19362
set background=light

nmap <space> <leader>
vmap <space> <leader>

" Permanent undo
set undodir=~/.vimdid
set undofile

set nocompatible

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500
set completeopt=menuone,noinsert,noselect

set ruler
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

" Fuzzy Finder
Plug '/home/hwchen/src/fzf/'
Plug 'junegunn/fzf.vim'
" Fuzzy finder for symbols/outline only (for now)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }

" consider removing this plugin because of https://github.com/nvim-treesitter/nvim-treesitter/issues/7872
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'main'}

" Editor
Plug 'airblade/vim-rooter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'ciaranm/securemodelines'
Plug 'phaazon/hop.nvim'

" Language support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ziglang/zig.vim'
Plug 'NoahTheDuke/vim-just'
Plug 'vmchale/dhall-vim'
Plug 'itspriddle/vim-shellcheck'

" Theme
Plug 'EdenEast/nightfox.nvim', { 'branch': 'main' }
Plug 'p00f/alabaster.nvim'
" alabaster theme queries are kept in .config/nvim/queries/c3/highlights.scm
" They will override the default nvim-treesitter queries https://github.com/nvim-treesitter/nvim-treesitter/issues/3146

" External
Plug 'numToStr/FTerm.nvim'

" Other
Plug 'stevearc/oil.nvim' "edit filesystem

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
"colo dayfox
colo alabaster
let g:alabaster_floatborder = 1

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

"toggles between buffers
nnoremap <space><space> <c-^>

"Search symbols using telescope/lsp
"nnoremap <leader>l :Telescope quickfix<CR>
"nnoremap <leader>e :Telescope diagnostics<CR>

nnoremap <leader>o <cmd>Telescope find_files<cr>
"nnoremap <leader>g <cmd>Telescope live_grep<cr>
" replaced with buffers picker
"nnoremap <leader>; <cmd>Telescope buffers<cr>
noremap <leader>; <cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>

"------------------------------------------------------
"Quickfix
nnoremap g; <cmd>cn<cr>
nnoremap g: <cmd>cp<cr>

"------------------------------------------------------
"Statusline

" turn off status line
set laststatus=0
set noshowmode

"hi clear StatusLine
"hi StatusLine ctermbg=black ctermfg=gray
"set laststatus=2
"let g:lightline = {
"    \ 'colorscheme': 'dayfox',
"    \ 'active': {
"    \   'left': [ [ 'mode', 'paste' ],
"    \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
"    \ },
"\ }

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

inoremap <c-s> <esc>:w<cr>
noremap <c-s> <esc>:w<cr>

noremap <leader>i <esc>:IndentLinesToggle<cr>

highlight TabLineFill ctermfg=Black
highlight TabLineSel ctermbg=Black ctermfg=Gray
highlight TabLine ctermbg=Black ctermfg=DarkBlue

"splits

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

" force markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" roc
autocmd BufNewFile,BufReadPost *.roc set filetype=roc

" c3
autocmd BufNewFile,BufReadPost *.c3 set filetype=c3
autocmd BufNewFile,BufReadPost *.c3l set filetype=c3
autocmd BufNewFile,BufReadPost *.c3i set filetype=c3
autocmd BufNewFile,BufReadPost *.c3 :setlocal noexpandtab
" set errorformat here so I can use `just` for make:
autocmd FileType c3 setlocal errorformat=(%f:%l:%c)\ %m


" odin
autocmd BufNewFile,BufReadPost *.odin :set filetype=odin
autocmd BufNewFile,BufReadPost *.odin :setlocal noexpandtab

" Rust
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

" ctags in general
" go definition
" If lsp, it will remap gd again
nnoremap gd <C-]>

" trailing whitespace

"set list listchars=tab:\|\ ,trail:·

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
"let g:neoterm_default_mod = 'botright'
"nnoremap <leader>t :Tnew<cr>
nnoremap <leader>t :!ghostty<cr>

" Hop (github.com/phaazon/hop)
"nnoremap <leader>j :HopLineStart<cr>
nnoremap <leader>w :HopWord<cr>
nnoremap <leader>/ :HopPattern<cr>

lua << END

-- Scratch buffer w/ command
vim.keymap.set("n", "<space>c", function()
  vim.ui.input({}, function(c) 
      if c and c~="" then 
        vim.cmd("noswapfile vnew") 
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
      end 
  end) 
end)


-- FloatTerm
require'FTerm'.setup({
    dimensions  = {
        height = 1.0,
        width = 1.0,
        x = 0.5,
        y = 0.5,
    },
})
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-ESC>','<C-\\><C-n>',{noremap = true})

-- Oil
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Hop
require 'hop'.setup()

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

local treesitter_langs = { 'c3', 'typst', 'rust', 'odin' }
require'nvim-treesitter'.install(treesitter_langs)
-- highlighting handled by alabaster
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c3', 'typst', 'rust', 'odin' },
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        --vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        ---- indentation, provided by nvim-treesitter
        --vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

END

" Grep and quickfix
if executable('rg')
      set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case        
      set grepformat=%f:%l:%c:%m
endif

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

nnoremap <leader>g :Grep 

" TODO toggle quickfix, set :compiler
