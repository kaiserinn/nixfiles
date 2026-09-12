return {
	src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
	data = {
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 10,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				zindex = 20,
				on_attach = nil,
			})
			vim.cmd.highlight("TreesitterContextBottom", "gui=underline")
		end,
	},
}
