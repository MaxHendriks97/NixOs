-- Text editing
require('mini.ai').setup()
require('mini.comment').setup()
require('mini.pairs').setup()

-- General workflow
require('mini.basics').setup({
    mappings = {
        basic = false,
    }
})
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
require('mini.trailspace').setup()
