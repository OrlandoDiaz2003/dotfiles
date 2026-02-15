-- OPTIONS
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.wrap           = false
vim.opt.expandtab      = true
vim.opt.list           = true
vim.opt.pumheight      = 10
vim.opt.virtualedit    = ""
vim.opt.cmdheight      = 0
vim.opt.tabstop        = 4
vim.opt.swapfile       = false
vim.opt.shiftwidth     = 4
vim.opt.smartindent    = true
vim.opt.smartcase      = true
vim.opt.hlsearch       = false
vim.o.listchars        = 'tab:→ ,lead:·,trail:·,space:·'
vim.opt.incsearch      = true
vim.opt.cursorline     = false
vim.opt.showmode       = true
vim.opt.termguicolors  = true
vim.opt.scrolloff      = 12
vim.opt.guicursor      = ""
vim.opt.colorcolumn    = "80"
vim.opt.winborder      = "none"
vim.opt.laststatus     = 2
vim.g.mapleader        = " "

--REMAPS
vim.keymap.set("n", "<Leader>e", "<cmd>Oil<CR>")
vim.keymap.set("n", "<Leader>w", "<cmd>write<CR>")
vim.keymap.set("n", "<Leader>q", ":quit<CR>")

vim.keymap.set("n", "<C-Right>", "<C-w>>")
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Up>", "<C-w>-")
vim.keymap.set("n", "<C-Down>", "<C-w>+")
vim.keymap.set("n", "<F9>", ":below Compile<CR>")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {noremap = true})
vim.keymap.set("n", "<Leader>t",  ":vsplit | wincmd l | term<CR>")

vim.keymap.set({ "n", "v", "x" }, "<Leader>y", '"+y <CR>')

vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format)

--Netrw config
vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0
vim.g.netrw_sizestyle = "H"
vim.g.netrw_timefmt = "%d %b %Y %H:%M"
vim.g.netrw_keepdir = 0

vim.api.nvim_create_autocmd('FileType', {
	pattern = "netrw",
	callback = function()
		vim.wo.relativenumber = true
		vim.wo.number = true
	end,

})

--Plugins
vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim"},
	{ src = "https://github.com/joshdick/onedark.vim"},
	{ src = "https://github.com/oskarnurm/koda.nvim"},
	{ src = "https://github.com/sphamba/smear-cursor.nvim"},
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master", },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/Saghen/blink.cmp",                opts = {}, },
	{ src = "https://github.com/neovim/nvim-lspconfig",           deps = { "blink.cmp" }, },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/ej-shafran/compile-mode.nvim" ,deps={'plenary'} },
	{ src = "https://github.com/windwp/nvim-ts-autotag", build = "make install_jsregexp", },
})

vim.g.compile_mode = {}

vim.cmd("color tokyonight-night")

--Plugin config
require"smear_cursor".enabled = true

require "oil".setup({
	columns = {
		"permissions",
		"size",
		"mtime"
	},
	view_options = {
		show_hidden = true,
	}
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		'c',
		'lua',
		'html',
		'css',
		'python',
		'javascript',
	},
	sync_install = false,
	auto_install = true,

	highlight = {
		enable =  true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'Handle nvim-treesitter updates',
	group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
	callback = function(event)
		if event.data.kind == 'update' then
			vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, 'TSUpdate')
			if ok then
				vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
			else
				vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
			end
		end
	end,
})

local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local ivy_opts = themes.get_ivy()

vim.keymap.set('n', '<leader><space>', function()
  builtin.find_files(ivy_opts)
end, { desc = 'Telescope find files (ivy)' })
vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep(ivy_opts)
end, { desc = 'Telescope live grep (ivy)' })
vim.keymap.set('n', '<leader>fb', function()
  builtin.buffers(ivy_opts)
end, { desc = 'Telescope buffers (ivy)' })
vim.keymap.set('n', '<leader>fh', function()
  builtin.help_tags(ivy_opts)
end, { desc = 'Telescope help tags (ivy)' })

require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"clangd", "bashls", "html", "emmet_ls"
	}
}
local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = { "clangd", "pyright", "bashls", "html", "emmet_ls", "ts_ls", "eslint" }

for _, server in ipairs(servers) do
	vim.lsp.config(server,{ capabilities = capabilities })
end

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = 'mono' },
	completion = { documentation = { auto_show = false } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "lua" }
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

require('nvim-ts-autotag').setup({})
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		virtual_text = {
			spacing = 5,
			severity_limit = 'Warning',
		},
		update_in_insert = true,
	}
)
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
