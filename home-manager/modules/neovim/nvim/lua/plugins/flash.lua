return {
    src = "https://github.com/folke/flash.nvim",
    data = {
        config = function()
            require("flash").setup({})
            local f = require("flash")
            vim.keymap.set({ "n", "x" }, "s", f.jump, { desc = "Flash: Flash jump" })
            vim.keymap.set("o", "r", f.remote, { desc = "Flash: Remote flash" })
            vim.keymap.set("c", "<C-s>", f.toggle, { desc = "Flash: Toggle flash search" })
        end,
    },
}
