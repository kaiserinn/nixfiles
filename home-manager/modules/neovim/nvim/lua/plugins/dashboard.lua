return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = "last session",
					action = 'lua require("persistence").load()',
					key = "s",
				},
				{
					desc = "config",
					group = "Number",
					action = "Config",
					key = "d",
				},
				{
					desc = "quit",
					action = "qa",
					key = "q",
				},
			},
			packages = { enable = false },
			project = { enable = false },
			mru = { limit = 2 },
			footer = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return {
					" ",
					"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
				}
			end,
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
