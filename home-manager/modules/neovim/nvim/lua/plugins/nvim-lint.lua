return {
	src = "https://github.com/mfussenegger/nvim-lint",
	data = {
		config = function()
			local lint = require("lint")
			lint.linters.gdlint = vim.tbl_deep_extend("force", lint.linters.gdlint or {}, {
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
			})
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				gdscript = { "gdlint" },
			}

			local function debounce(ms, fn)
				local timer = vim.uv.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = debounce(100, function()
					lint.try_lint()
				end),
			})
		end,
	},
}
