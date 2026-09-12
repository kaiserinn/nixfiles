-- Combined small specs. Returns a LIST of specs, flattened by
-- utils.flatten_spec in plugins/init.lua, so it can sit anywhere in the list.
return {
    {
        src = "https://github.com/windwp/nvim-autopairs",
        data = {
            config = function()
                require("nvim-autopairs").setup()
            end,
        },
    },

    {
        src = "https://github.com/kylechui/nvim-surround",
        data = {
            config = function()
                require("nvim-surround").setup({})
            end,
        },
    },

    {
        src = "https://github.com/Wansmer/treesj",
        data = {
            config = function()
                require("treesj").setup({})

                vim.keymap.set("n", "<leader>m", "<cmd>TSJToggle<cr>", { desc = "Treesj: Toggle treesj" })
            end,
        },
    },

    {
        src = "https://github.com/karb94/neoscroll.nvim",
        data = {
            config = function()
                require("neoscroll").setup({
                    duration_multiplier = 0.2,
                })
            end,
        },
    },

    {
        src = "https://github.com/j-hui/fidget.nvim",
        data = {
            config = function()
                require("fidget").setup({})
            end,
        },
    },

    {
        src = "https://github.com/vyfor/cord.nvim",
        data = {
            config = function()
                require("cord").setup({
                    idle = {
                        timeout = 1800000,
                    },
                })
            end,
        },
    },

    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
        data = {
            config = function()
                require("ibl").setup({
                    exclude = {
                        filetypes = { "dashboard" },
                    },
                })
            end,
        },
    },
}
