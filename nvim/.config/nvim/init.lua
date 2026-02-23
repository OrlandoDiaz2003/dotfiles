-- OPTIONS
vim.o.number         = true
vim.o.relativenumber = true
vim.o.wrap           = false
vim.o.expandtab      = true
vim.o.list           = false
vim.o.pumheight      = 10
vim.o.virtualedit    = ""
vim.o.cmdheight      = 0
vim.o.tabstop        = 4
vim.o.swapfile       = false
vim.o.shiftwidth     = 4
vim.o.smartindent    = true
vim.o.smartcase      = true
vim.o.hlsearch       = false
vim.o.listchars      = 'tab:→ ,lead:·,trail:·,space:·'
vim.o.guifont        = "Cascadia Mono:14"
vim.o.incsearch      = true
vim.o.cursorline     = false
vim.o.showmode       = true
vim.o.termguicolors  = true
vim.o.scrolloff      = 12
vim.o.guicursor      = ""
vim.o.colorcolumn    = "80"
vim.o.winborder      = "none"
vim.o.laststatus     = 1
vim.o.lazyredraw     = true
vim.o.ttimeoutlen    = 10
vim.g.mapleader      = " "
--REMAPS
vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle dir=./ reveal<CR>")
vim.keymap.set("n", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>")
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
--Plugins
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim"},
    { src = "https://github.com/rebelot/kanagawa.nvim"},
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
    { src = "https://github.com/romgrk/barbar.nvim"},
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    --Dependencies
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    { src = "https://github.com/windwp/nvim-autopairs" },
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

vim.cmd("color kanagawa")

vim.g.barbar_auto_setup = false
require 'barbar'.setup {
    auto_hide = true
}
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)


--Plugin config
require "nvim-autopairs".setup({
    event = "InsertEnter",
    config = true
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
    auto_pairs = {
        enable = true
    }
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg',      builtin.live_grep , { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb',      builtin.buffers   , { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh',      builtin.help_tags , { desc = 'Telescope help tags' })

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
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

require('nvim-ts-autotag').setup({})
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', '<leader>k', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
