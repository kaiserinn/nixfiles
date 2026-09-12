local mode_map = {
	['NORMAL']    = 'NOR',
	['INSERT']    = 'INS',
	['VISUAL']    = 'VIS',
	['V-LINE']    = 'V-L',
	['V-BLOCK']   = 'V-B',
	['SELECT']    = 'SEL',
	['S-LINE']    = 'S-L',
	['S-BLOCK']   = 'S-B',
	['REPLACE']   = 'REP',
	['V-REPLACE'] = 'V-R',
	['COMMAND']   = 'CMD',
	['EX']        = 'EX',
	['TERMINAL']  = 'TERM',
}

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
					color = function()
						local suffix = require('lualine.highlight').get_mode_suffix()

						if suffix == '_normal' then
							local ok, palette = pcall(require, 'rose-pine.palette')
							if ok and palette and palette.iris then
								return { fg = palette.iris }
							end
						end

						local hl = vim.api.nvim_get_hl(0, { name = 'lualine_a' .. suffix })
						local color = hl.bg or hl.fg
						if color then
							return { fg = string.format('#%06x', color) }
						end
					end,
					padding = { left = 0, right = 1 },
				},
				{
					'mode',
					fmt = function(str)
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
