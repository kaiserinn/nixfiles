return {
    'romgrk/barbar.nvim',
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = false,
        auto_hide = 1,
        insert_at_end = true,
        icons = {
            buffer_index = false,
            buffer_number = false,
            button = false,
            diagnostics = { enabled = false },
            gitsigns = { enabled = false },
            filetype = {
                custom_colors = false,
                enabled = false,
            },
            separator = { left = '', right = '' },
            separator_at_end = false,
            inactive = { separator = { left = "" } },
            preset = 'default',
        },
        maximum_padding = 2,
        minimum_padding = 1,
        maximum_length = 30,
        minimum_length = 0,
        semantic_letters = true,
    },
    config = function(_, opts)
        require("barbar").setup(opts)

        vim.keymap.set("n", "<leader>p", "<CMD>BufferPick<CR>", { desc = "barbar: buffer pick mode", silent = true })
    end
}
