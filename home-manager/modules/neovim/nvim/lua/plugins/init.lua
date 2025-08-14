return {

	-- Git related plugins
	"tpope/vim-fugitive",
	-- 'tpope/vim-rhubarb',

	"tpope/vim-abolish",

	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},

	-- Discord rich presence
	{
		"andweeb/presence.nvim",
		event = "BufRead",
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		event = "BufReadPre",
		config = function()
			require("ibl").setup({
				exclude = {
					filetypes = { "dashboard" },
				},
			})
		end,
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		opts = {},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
		keys = {
			{ "gcc", mode = "n", desc = "Comment: toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment: toggle linewise" },
			{ "gc", mode = "x", desc = "Comment: toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment: toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment: toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment: toggle blockwise (visual)" },
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {
			filetypes = { "html", "rust" },
		},
	},

	{
		"folke/persistence.nvim",
		-- event = "BufReadPre", -- this will only start session saving when an actual file was opened
		event = "VimEnter",
		config = function()
			local opts = function(desc)
				return { desc = "Persistence: " .. desc }
			end

			-- load the session for the current directory
			vim.keymap.set("n", "<leader>qs", function()
				require("persistence").load()
			end)

			-- select a session to load
			vim.keymap.set("n", "<leader>qS", function()
				require("persistence").select()
			end)

			-- load the last session
			vim.keymap.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end)

			-- stop Persistence => session won't be saved on exit
			vim.keymap.set("n", "<leader>qd", function()
				require("persistence").stop()
			end)
			require("persistence").setup()
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "InsertEnter",
		opts = {},
		keys = { "ys", "ds", "cs" },
	},

	{
		"folke/flash.nvim",
		opts = {},
    -- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash: Flash jump" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Flash: Remote Flash" },
			{ "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Flash: Toggle Flash Search" },
		},
	},

	{
		"Wansmer/treesj",
		-- event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		keys = { { "<leader>m", desc = "Treesj: Toggle treesj" } },
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			-- separator = "—",
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
		config = function(_, opts)
			require("treesitter-context").setup(opts)
			vim.cmd.highlight("TreesitterContextBottom", "gui=underline")
		end,
	},

	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>n",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
			-- the zindex of the yazi floating window. Can be used to make the yazi
			-- window fullscreen. See `:h nvim_open_win()` for more information.
			floating_window_scaling_factor = 1,
			yazi_floating_window_zindex = 200,
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},

{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
}

}
