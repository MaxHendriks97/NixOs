MiniDeps.add({
    source = "neovim/nvim-lspconfig"
})

MiniDeps.add({
    source = 'mason-org/mason.nvim'
})

MiniDeps.add({
    source = "mason-org/mason-lspconfig.nvim",
    depends = {
        "neovim/nvim-lspconfig",
        "mason-org/mason.nvim"
    }
})

require('mason').setup()
require("mason-lspconfig").setup()

MiniDeps.add({
    source = "folke/lazydev.nvim"
})

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    }
})

