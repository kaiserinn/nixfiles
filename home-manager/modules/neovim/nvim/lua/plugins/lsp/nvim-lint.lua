return {
	"mfussenegger/nvim-lint",
	opts = {
		events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
		linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			gdscript = { "gdlint" },
		},
		---@type table<string,table>
		linters = {
			gdlint = {
				-- see https://github.com/mfussenegger/nvim-lint/pull/789
				parser = function(output, bufnr, linter_cwd)
					local pattern = [[(.+):(%d+):%s(%a+):%s(.*)]]
					local groups = {
						"file",
						"lnum",
						"severity",
						"message",
					}
					local severity_map = {
						["Error"] = vim.diagnostic.severity.WARN,
					}

					return require("lint.parser").from_pattern(pattern, groups, severity_map, { ["source"] = "gdlint" })(
						output,
						bufnr,
						linter_cwd
					)
				end,
			},
		},
	},
	config = function(_, opts)
		local M = {}

		local lint = require("lint")
		for name, linter in pairs(opts.linters) do
			if type(linter) == "table" and type(lint.linters[name]) == "table" then
				lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
				if type(linter.prepend_args) == "table" then
					lint.linters[name].args = lint.linters[name].args or {}
					vim.list_extend(lint.linters[name].args, linter.prepend_args)
				end
			else
				lint.linters[name] = linter
			end
		end
		lint.linters_by_ft = opts.linters_by_ft

		function M.debounce(ms, fn)
			local timer = vim.uv.new_timer()
			return function(...)
				local argv = { ... }
				timer:start(ms, 0, function()
					timer:stop()
					vim.schedule_wrap(fn)(unpack(argv))
				end)
			end
		end

		vim.api.nvim_create_autocmd(opts.events, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = M.debounce(100, function()
				lint.try_lint()
			end),
		})
	end,
}
