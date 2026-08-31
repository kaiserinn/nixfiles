local function get_foo(opts)
    opts = opts or {}

    local theme_opts = {
        theme = "ivy",

        sorting_strategy = "ascending",

        layout_strategy = "bottom_pane",
        layout_config = {
            height = 25,
        },

        border = true,
        borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { " " },
        },
    }
    if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
        theme_opts.borderchars = {
            prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
            results = { "─", " ", " ", " ", "─", "─", " ", " " },
            preview = { " ", " ", " ", " ", " ", " ", " ", " " },
        }
    end

    return vim.tbl_deep_extend("force", theme_opts, opts)
end

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
        -- { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
        local open_with_trouble = require("trouble.sources.telescope").open

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
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

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local ivy = require('telescope.themes').get_ivy({
            borderchars = {
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { " " },
                preview = { " " },
            }
        })

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>ff", function() builtin.find_files(ivy) end, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>se", builtin.builtin, { desc = " gS]earch Select Telescope" })
        vim.keymap.set("n", "<leader>sg", function() builtin.live_grep(ivy) end, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = "~/.config/nix/home-manager/modules/neovim/nvim" })
        end, { desc = "[S]earch [N]eovim files" })
    end,
}
