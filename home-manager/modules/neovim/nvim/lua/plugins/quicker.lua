return {
    src = "https://github.com/stevearc/quicker.nvim",
    data = {
        config = function()
            require("quicker").setup(
                {
                    keys = {
                        {
                            ">",
                            function()
                                require("quicker").expand({ before = 1, after = 1, add_to_existing = true })
                            end,
                            desc = "Expand quickfix context",
                        },
                        {
                            "<",
                            function()
                                require("quicker").collapse()
                            end,
                            desc = "Collapse quickfix context",
                        },
                    },
                })
        end
    }
}
