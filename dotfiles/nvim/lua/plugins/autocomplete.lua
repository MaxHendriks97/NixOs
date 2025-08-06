MiniDeps.add({
    source = "saghen/blink.cmp",
    depends = { "rafamadriz/friendly-snippets" },
    checkout = "v1.4.1",
})
require("blink.cmp").setup({
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            }
        }
    },
    signature = {
        enabled = true,
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
        ghost_text = {
            enabled = true
        },
    },
    keymap = {
        preset = "default",

        ["<Up>"] = { 'scroll_documentation_up', 'fallback' },
        ["<Down>"] = {'scroll_documentation_down', 'fallback'},
        ["<S-Tab>"] = { 'select_prev', 'fallback' },
        ["<Tab>"] = { 'select_next', 'fallback' },
        ["<Enter>"] = { 'accept', 'fallback' },
        ["<Right>"] = { 'accept', 'fallback' },
    },
})
