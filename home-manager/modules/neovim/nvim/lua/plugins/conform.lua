return {
	src = "https://github.com/stevearc/conform.nvim",
	data = {
		config = function()
			require("conform").setup({
				notify_on_error = true,
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascriptreact = { "prettierd" },
					php = { "pint" },
					gdscript = { "gdformat" },
					go = { "gofmt" },
					rust = { "rustfmt" },
					nix = { "alejandra" },
				},
			})

			vim.keymap.set("", "<leader>fm", function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end, { desc = "[F]ormat buffer" })
		end,
	},
}
