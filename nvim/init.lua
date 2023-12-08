vim.cmd([[set completeopt=menu,menuone,noselect

let mapleader=" "

nnoremap <leader>w :w<CR>
nnoremap <leader>ll :%!eslint --fix

nnoremap <leader>e :NvimTreeToggle<CR>

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

nnoremap <silent> gf :Lspsaga finder<CR>
nnoremap <silent><leader>. :Lspsaga code_action<CR>
nnoremap <silent><leader>t :Lspsaga peek_type_definition<CR>
nnoremap <silent><leader>k :Lspsaga peek_definition<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>

nnoremap <silent><leader>gb :GitBlame<CR>
nnoremap <silent><leader><Esc> :call feedkeys("\<C-\><C-N>")
]])

vim.g.codeium_disable_bindings = 1

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
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.showtabline = 0 -- always show tabs

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

require("lazy").setup("plugins")

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings

	-- to learn the available actions

	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})

require("mason-lspconfig").setup({

	-- Replace the language servers listed here

	-- with the ones you want to install

	ensure_installed = { "tsserver" },

	handlers = {

		lsp_zero.default_setup,
	},
})
vim.opt.termguicolors = true

local attach_opts = { silent = true, buffer = bufnr }

vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, attach_opts)
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, attach_opts)
vim.keymap.set("n", "gS", require("telescope.builtin").lsp_workspace_symbols, attach_opts)
vim.keymap.set("n", "gs", require("telescope.builtin").lsp_document_symbols, attach_opts)
vim.keymap.set("n", "gF", function()
	require("telescope.builtin").lsp_workspace_symbols({ symbols = "functions" })
end, attach_opts)
vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, attach_opts)
vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, attach_opts)
vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, attach_opts)
vim.keymap.set("n", "<space>Wa", vim.lsp.buf.add_workspace_folder, attach_opts)
vim.keymap.set("n", "<space>Wr", vim.lsp.buf.remove_workspace_folder, attach_opts)
vim.keymap.set("n", "<space>Wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, attach_opts)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, attach_opts)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, attach_opts)
--vim.keymap.set("n", "<space>cA", vim.lsp.buf.range_code_action, attach_opts)
