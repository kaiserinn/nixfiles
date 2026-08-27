local palette = require('rose-pine.palette')

return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
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
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					function()
						return '▊'
					end,
					color = { fg = palette.iris },
					padding = { left = 0, right = 1 },
				},
				{
					'mode',
					fmt = function(str)
						local mode_map = {
							['NORMAL'] = 'NOR',
							['INSERT'] = 'INS',
							['VISUAL'] = 'VIS',
							['V-LINE'] = 'V-L',
							['V-BLOCK'] = 'V-B',
							['REPLACE'] = 'REP',
							['COMMAND'] = 'CMD',
							['SELECT'] = 'SEL',
							['TERMINAL'] = 'TERM',
							['EX'] = 'EX',
						}
						return mode_map[str] or str
					end,
					padding = { left = 1, right = 2 }
				},
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = {
						error = "󰝥 ",
						warn = "󰝥 ",
						hint = "󰝥 ",
						info = "󰝥 ",
					},
				},
				"location"
			},
			lualine_y = {},
			lualine_z = {}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
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
