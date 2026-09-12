return {
    src = "https://github.com/folke/trouble.nvim",
    data = {
        config = function()
            require("trouble").setup({
                focus = true,
            })

            vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Diagnostics" })
            vim.keymap.set(
                "n",
                "<leader>tb",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                { desc = "Trouble: Buffer Diagnostics" }
            )
            vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",
                { desc = "Trouble: Symbols" })
            vim.keymap.set(
                "n",
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                { desc = "Trouble: LSP Definitions / references / ..." }
            )
            vim.keymap.set("n", "<leader>txL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble: Location List" })
            vim.keymap.set("n", "<leader>txQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: Quickfix List" })
        end
    }
}
