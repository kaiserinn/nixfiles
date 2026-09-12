return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
        local open_with_trouble = require("trouble.sources.telescope").open

        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            defaults = {
                mappings = {
                    i = { ["<c-t>"] = open_with_trouble },
                    n = { ["<c-t>"] = open_with_trouble },
                },
            },
        })

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local ivy = require('telescope.themes').get_ivy({
            borderchars = {
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { " " },
                preview = { " " },
            }
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Telescope: keymaps" })
        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files(vim.tbl_extend("keep", { hidden = true }, ivy))
        end, { desc = "Telescope: find files" })
        vim.keymap.set("n", "<leader>se", builtin.builtin, { desc = "Telescope: search builtin" })
        vim.keymap.set("n", "<leader>sg", function() builtin.live_grep(ivy) end, { desc = "Telescope: live grep" })
        vim.keymap.set("n", "<leader>sf", function() builtin.git_files(ivy) end, { desc = "Telescope: git files" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope: resume search" })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope: buffers" })

        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = "~/.config/nix/home-manager/modules/neovim/nvim" })
        end, { desc = "[S]earch [N]eovim files" })
    end,
}
