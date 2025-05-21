-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add

-- General settings
vim.o.termguicolors = true
vim.o.cursorline = true
vim.wo.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Mini plugins
-- Text editing
require('mini.ai').setup()
require('mini.comment').setup()
require('mini.pairs').setup()

-- General workflow
require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.bufremove').setup()
local miniclue = require('mini.clue')
miniclue.setup({
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
	},

	triggers = {
		-- leader triggers
		{ mode = 'n', keys = '<leader>' },
		{ mode = 'x', keys = '<leader>' },

        -- 'g' key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },
	},

	window = {
		config = {},
		delay = 500,
		scroll_down = '<C_d>',
		scroll_up = '<C_u>',
	},
})
require('mini.files').setup({
	mappings = {
		go_in = "<Right>",
		go_out = "<Left>",
	},
})

-- Appearance
require('mini.cursorword').setup()
--require('mini.hues').setup({ background = '#272e33', foreground = '#d3c6aa' })
require('mini.base16').setup({
    palette = {
        base00 = '#272e33',
        base01 = '#2e383c',
        base02 = '#414b50',
        base03 = '#859289',
        base04 = '#9da9a0',
        base05 = '#d3c6aa',
        base06 = '#e4e1cd',
        base07 = '#fdf6e3',
        base08 = '#7fbbb3',
        base09 = '#d699b6',
        base0A = '#dbbc7f',
        base0B = '#83c092',
        base0C = '#e69875',
        base0D = '#a7c080',
        base0E = '#e67e80',
        base0F = '#7a8478',
    },
})
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

-- General plugins
add({
    source = "nvim-treesitter/nvim-treesitter"
})
require('nvim-treesitter.configs').setup({ highlight = { enable = true } })

add({
	source = 'MeanderingProgrammer/render-markdown.nvim',
	depends = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
})
add({
	source = 'tpope/vim-fugitive',
})
add({
    source = 'chrisgrieser/nvim-spider'
})
add({
    source = "folke/flash.nvim"
})

-- Neorg
add({
    source = "nvim-neorg/neorg",
    depends = { "nvim-neorg/lua-utils.nvim", "pysan3/pathlib.nvim", "nvim-neotest/nvim-nio" }
})
require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Neorg",
                },
                default_workspace = "notes"
            },
        },
    },
})

-- Telescope
add({
	source = 'nvim-telescope/telescope-fzf-native.nvim',
})
add({
	source = 'nvim-telescope/telescope.nvim',
	depends = { 'nvim-lua/plenary.nvim' },
})
require('telescope').setup({
	defaults = {
		path_display = "smart",
	},
	extensions = {

	}
})

-- Keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', {})
vim.keymap.set('', 'w', function() require('spider').motion('w') end, {})
vim.keymap.set('', 'e', function() require('spider').motion('e') end, {})
vim.keymap.set('', 'b', function() require('spider').motion('b') end, {})
vim.keymap.set('', 'ge', function() require('spider').motion('ge') end, {})
vim.keymap.set('', ' ', '<Nop>', { silent = true })
vim.keymap.set('', '<leader>f', '', { desc = 'File' })
vim.keymap.set('', '<leader>fs', '<CMD>w<CR>', { desc = 'Save file' })
vim.keymap.set('', '<leader>q', '', { desc = 'Quit/Session' })
vim.keymap.set('', '<leader>qq', '<CMD>qa<CR>', { desc = 'quit' })
vim.keymap.set('', '<leader>b', '', { desc = 'Buffer' })
vim.keymap.set('', '<leader>bk', function() MiniBufremove.delete(0) end, { desc = 'Kill buffer' })
vim.keymap.set('', '<leader>bK', '<CMD>%bd<CR>', { desc = 'Kill all buffers' })
vim.keymap.set('', 'gt', function() MiniBracketed.buffer('forward') end, {})
vim.keymap.set('', 'gT', function() MiniBracketed.buffer('backward') end, {})
vim.keymap.set('', '<leader>w', '', { desc = 'Window' })
vim.keymap.set('', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('', '<leader>wh', '<CMD>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('', '<leader>wc', '<CMD>q<CR>', { desc = 'Close window' })
vim.keymap.set('', '<leader>w<up>', '<CMD>wincmd k<CR>', { desc = 'Select window up' })
vim.keymap.set('', '<leader>w<down>', '<CMD>wincmd j<CR>', { desc = 'Select window down' })
vim.keymap.set('', '<leader>w<left>', '<CMD>wincmd h<CR>', { desc = 'Select window left' })
vim.keymap.set('', '<leader>w<right>', '<CMD>wincmd l<CR>', { desc = 'Select window right' })
vim.keymap.set('', '<leader>o', '', { desc = 'Open' })
vim.keymap.set('', '<leader>op', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open file browser at current file' })
vim.keymap.set('', '<leader>of', function() MiniFiles.open() end, { desc = 'Open file browser at root' })
vim.keymap.set('', '<leader>g', '', { desc = 'Git' })
vim.keymap.set('', '<leader>gg', '<CMD>Git<CR>', { desc = 'Open Fugitive' })
