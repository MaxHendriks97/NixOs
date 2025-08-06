MiniDeps.add({
    source = "obsidian-nvim/obsidian.nvim",
    depends = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }
})
require("obsidian").setup({
    legacy_commands = false,
    workspaces = {
        {
            name = "Douane",
            path = "~/Documents/Douane",
        },
        {
            name = "Second Brain",
            path = "~/Documents/Second Brain",
        }
    },
    follow_url_func = function(url)
        vim.ui.open(url)
    end,
    follow_img_func = function(img)
        vim.ui.open(img)
    end,
    footer = {
        enabled = false,
    },
})
