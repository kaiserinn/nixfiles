return {
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    {
        src = "https://github.com/nvim-telescope/telescope.nvim",
        data = {
            config = function()
                local safely = require("utils").safely

                local _, open_with_trouble = safely(function()
                    return require("trouble.sources.telescope").open
                end, "Telescope: trouble is not loaded")

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

                safely(function()
                    require("telescope").load_extension("fzf")
                    require("telescope").load_extension("ui-select")
                end, "Telescope: could not load extensions")

                local ivy = require("telescope.themes").get_ivy({
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { " " },
                    },
                })

                local b = require("telescope.builtin")

                local function find_files()
                    b.find_files(vim.tbl_extend("keep", { hidden = true }, ivy))
                end
                local function live_grep()
                    b.live_grep(ivy)
                end
                local function git_files()
                    b.git_files(ivy)
                end

                vim.keymap.set("n", "<leader>sk", b.keymaps, { desc = "Telescope: keymaps" })
                vim.keymap.set("n", "<leader>ff", find_files, { desc = "Telescope: find files" })
                vim.keymap.set("n", "<leader>se", b.builtin, { desc = "Telescope: search builtin" })
                vim.keymap.set("n", "<leader>sg", live_grep, { desc = "Telescope: live grep" })
                vim.keymap.set("n", "<leader>sf", git_files, { desc = "Telescope: git files" })
                vim.keymap.set("n", "<leader>sr", b.resume, { desc = "Telescope: resume search" })
                vim.keymap.set("n", "<leader><leader>", b.buffers, { desc = "Telescope: buffers" })

                vim.keymap.set("n", "<leader>sn", function()
                    b.find_files({ cwd = "~/.config/nix/home-manager/modules/neovim/nvim" })
                end, { desc = "[S]earch [N]eovim files" })

                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
                    callback = function(event)
                        local map = function(keys, func, desc)
                            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Telescope LSP: " .. desc })
                        end

                        map("grr", b.lsp_references, "Goto references")
                        map("gri", b.lsp_implementations, "Goto implementation")
                        map("gd", b.lsp_definitions, "Goto definition")
                        map("gW", b.lsp_dynamic_workspace_symbols, "Open workspace symbols")
                        map("grt", b.lsp_type_definitions, "Goto type definition")
                        map("gs", function()
                            b.lsp_document_symbols(require("telescope.themes").get_dropdown({
                                previewer = false,
                            }))
                        end, "Open document symbols")
                    end,
                })
            end,
        },
    },
}
