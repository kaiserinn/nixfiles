return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard" },
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				-- "branch",
				-- { "diff", padding = { left = 0, right = 1 } },
			},
			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = " ",
						warn = " ",
						hint = " ",
						info = " ",
					},
				},
				-- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				"filename",
			},
			lualine_x = {},
			lualine_y = {
				"branch"
				-- { "filetype", icon_only = true, separator = "" },
			},
			-- lualine_z = {},
			-- lualine_z = {
			-- 	function()
			-- 		return " " .. os.date("%R")
			-- 	end,
			-- },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	event = "VeryLazy",
}
