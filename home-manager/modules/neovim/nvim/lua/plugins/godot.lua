return {
	src = "https://github.com/neovim/nvim-lspconfig",
	data = {
		config = function()
			local safely = require("utils").safely

			local paths_to_check = { "/", "/../" }
			local is_godot_project = false
			local godot_project_path = ""
			local cwd = vim.fn.getcwd()

			for _, value in pairs(paths_to_check) do
				if vim.uv.fs_stat(cwd .. value .. "project.godot") then
					is_godot_project = true
					godot_project_path = cwd .. value
					break
				end
			end

			local is_server_running = godot_project_path ~= ""
				and vim.uv.fs_stat(godot_project_path .. "/server.pipe")
			if is_godot_project and not is_server_running then
				vim.fn.serverstart(godot_project_path .. "/server.pipe")
			end

			if is_godot_project then
				safely(function()
					require("lspconfig").gdscript.setup({})
				end, "Godot: nvim-lspconfig is not loaded")
			end
		end,
	},
}
