-- if you use `open_for_directories=true`, this is recommended
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    src = "https://github.com/mikavilpas/yazi.nvim",
    data = {
        config = function()
            require("yazi").setup({
                -- if you want to open yazi instead of netrw, see below for more info
                open_for_directories = false,
                keymaps = {
                    show_help = "<f1>",
                },
                -- the zindex of the yazi floating window. Can be used to make the yazi
                -- window fullscreen. See `:h nvim_open_win()` for more information.
                floating_window_scaling_factor = 1,
                yazi_floating_window_zindex = 200,
            })

            vim.keymap.set({ "n", "v" }, "<leader>n", "<cmd>Yazi<cr>",
                { desc = "Yazi: open yazi at the current file" })
            vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>",
                { desc = "Yazi: open the file manager in nvim's working directory" })
        end
    }
}
