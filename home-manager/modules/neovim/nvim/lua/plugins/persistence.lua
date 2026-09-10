return {
	src = "https://github.com/folke/persistence.nvim",
	data = {
		config = function()
			require("persistence").setup()

			vim.keymap.set("n", "<leader>qs", function()
				require("persistence").load()
			end, { desc = "Persistence: load session for current directory" })
			vim.keymap.set("n", "<leader>qS", function()
				require("persistence").select()
			end, { desc = "Persistence: select session to load" })
			vim.keymap.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end, { desc = "Persistence: load last session" })
			vim.keymap.set("n", "<leader>qd", function()
				require("persistence").stop()
			end, { desc = "Persistence: stop session saving" })
		end,
	},
}
