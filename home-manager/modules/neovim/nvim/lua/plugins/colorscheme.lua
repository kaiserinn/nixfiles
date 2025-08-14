return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent_background = true,
	-- 		styles = {
	-- 			loops = { "italic" },
	-- 			functions = { "italic" },
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("catppuccin").setup(opts)
	-- 		vim.cmd([[colorscheme catppuccin-mocha]])
	-- 	end,
	-- },

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	enabled = true,
	-- 	opts = {
	-- 		theme = "lotus",
	-- 		transparent = true,
	-- 		styles = {
	-- 			loops = { "italic" },
	-- 			functions = { "italic" },
	-- 		},
	-- 		colors = {
	-- 			theme = {
	-- 				all = {
	-- 					ui = {
	-- 						bg_gutter = "none",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("kanagawa").setup(opts)
	-- 		vim.cmd([[colorscheme kanagawa-dragon]])
	-- 	end,
	-- },

	-- {
	-- 	"vague2k/vague.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other plugins
	-- 	opts = {
	-- 		transparent = false,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("vague").setup(opts)
	-- 		vim.cmd("colorscheme vague")
	-- 	end,
	-- },

	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = true,
		opts = {
			styles = {
				transparency = true,
			},
			highlight_groups = {
				FlashLabel = { bg = "transparent", fg = "gold" },
				FlashCurrent = { bg = "gold", fg = "text", blend = 30 },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
