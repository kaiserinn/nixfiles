return {
    src = "https://github.com/nvimdev/dashboard-nvim",
    data = {
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            icon_hl = "@variable",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f",
                        },
                        {
                            desc = "last session",
                            action = 'lua require("persistence").load()',
                            key = "s",
                        },
                        {
                            desc = "quit",
                            action = "qa",
                            key = "q",
                        },
                    },
                    packages = { enable = false },
                    project = { enable = false },
                    mru = { limit = 2 },
                    footer = {},
                },
            })
        end
    }
}
