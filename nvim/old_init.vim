local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

call plug#begin()

"themes 
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'luisiacc/gruvbox-baby'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/eslint.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'ray-x/lsp_signature.nvim',
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'RRethy/vim-illuminate'
Plug 'lukas-reineke/lsp-format.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-emoji',
Plug 'hrsh7th/cmp-nvim-lua',
Plug 'onsails/lspkind-nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'windwp/nvim-ts-autotag'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'yamatsum/nvim-cursorline'

Plug 'tami5/lspsaga.nvim'

Plug 'folke/trouble.nvim'

Plug 'nvim-lua/plenary.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'TimUntersberger/neogit'

Plug 'dinhhuy258/git.nvim'

Plug 'dinhhuy258/git.nvim'

Plug 'williamboman/mason.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()

"autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
"Large files highlighting
"autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
"autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

set relativenumber
set rnu

set bg=dark
set termguicolors
colorscheme gruvbox-baby

lua require("utils")
lua require("colors")
lua require("lsp")
lua require("cmp-config")
lua require("treesitter-config")
lua require("bufferline-config")
lua require("treeexplorer-config")
lua require("lspsaga-config")
lua require("gitsigns-config")
lua require("telescope-config")
lua require("git-config")
lua require("cursorline-config")

set completeopt=menu,menuone,noselect

let mapleader=" "

nnoremap <leader>w :w<CR>
nnoremap <leader>ll :%!eslint --fix

nnoremap <leader>ll :NvimTreeToggle<CR>
nnoremap <leader>l :NvimTreeFocus<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>n <cmd>Telescope file_browser<cr>

"buffers
nnoremap <leader>w :w<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>l :BufferLineCycleNext<CR>
nnoremap <leader>h :BufferLineCyclePrev<CR>
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>. :Lspsaga code_action<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>

nnoremap <silent><leader>gb :GitBlame<CR>
nnoremap <silent><leader><Esc> :call feedkeys("\<C-\><C-N>")

lua << END
require('lualine').setup()
require("trouble").setup {}


vim.g.border_style = "rounded"
vim.g.markdown_fenced_languages = {
    "bash=sh",
}
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "" -- don't use clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true -- highlight the current line
vim.opt.expandtab = false -- convert tabs to spaces
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.list = true
vim.opt.listchars = "tab:│ ,trail:·,nbsp:+"
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 1 -- set number column width to 2 {default 4}
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.scrolloff = 4 -- is one of my fav
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.spell = false -- disable spell checking
vim.opt.spelllang = "en" -- language for spell checking
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.timeoutlen = 500 -- timeout length
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.wrap = true -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.showtabline = 2 -- always show tabs
END
