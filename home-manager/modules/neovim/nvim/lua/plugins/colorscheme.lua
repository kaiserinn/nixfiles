return {
    src = "https://github.com/rose-pine/neovim",
    name = "rose-pine",
    data = {
        config = function()
            require("rose-pine").setup({
                styles = {
                    transparency = true,
                },
                highlight_groups = {
                    FlashLabel = { bg = "transparent", fg = "gold" },
                    FlashCurrent = { bg = "gold", fg = "text", blend = 30 },
                    StatusLine = { fg = "subtle", bg = "surface" },
                    StatusLineNC = { fg = "subtle", bg = "surface" },
                },
                enable = {
                    terminal = false,
                },
            })
            vim.cmd("colorscheme rose-pine")
        end
    }
}
