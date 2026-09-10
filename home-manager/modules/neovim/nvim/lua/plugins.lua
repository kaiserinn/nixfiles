require("plugins.build")
local u = require("utils")

local opts = {
    load = function(plugin)
        local data = plugin.spec.data or {}
        vim.cmd.packadd(plugin.spec.name)
        if data.config then
            data.config(plugin)
        end
    end,
}

vim.pack.add(
    u.flatten_spec({
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
        require("plugins.colorscheme"),
        require("plugins.lualine"),
        require("plugins.dashboard"),
        require("plugins.barbar"),
    }),
    opts
)

-- Load not during startup
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#lazy-loading:~:text=Load%20not%20during%20startup
vim.schedule(function()
    vim.pack.add(
        u.flatten_spec({
            require("plugins.nvim-treesitter"),
            require("plugins.treesitter-context"),
            require("plugins.trouble"),
            require("plugins.telescope"),

            -- lsp, linters, and formatters
            require("plugins.lsp"),
            require("plugins.completion"), -- blink, luasnip, lazydev
            require("plugins.conform"),
            require("plugins.nvim-lint"),

            -- Mappings internally handled by mini (I don't like that)
            -- See default mappings `:h MiniComment.config`
            "https://github.com/nvim-mini/mini.comment",

            require("plugins.quicker"),
            require("plugins.yazi"),
            "https://github.com/tpope/vim-abolish",
            "https://github.com/tpope/vim-sleuth",
            require("plugins.gitsigns"),
            require("plugins.persistence"),
            require("plugins.flash"),

            require("plugins.misc"),
            -- require("plugins.godot"),
        }),
        opts
    )
end)

