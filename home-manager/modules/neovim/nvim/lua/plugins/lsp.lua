return {
	src = "https://github.com/neovim/nvim-lspconfig",
	data = {
		--  See `:help lsp-config` for information about keys and how to configure
		---@type table<string, vim.lsp.Config>
		servers = {
			clangd = {},
			emmet_language_server = {},
			cssls = {},
			tailwindcss = {},
			vtsls = {},
			intelephense = {},
			gopls = {},
			pyright = {},
			zls = {
				settings = {
					zls = {
						build_on_save_args = { "-fincremental" },
					},
				},
			},
			dartls = {},
			tinymist = {},
			wgsl_analyzer = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},
			svelte = {},
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixfmt" },
				},
				options = {
					nixos = {
						expr = '(builtins.getFlake "/tmp/NixOS_Home-Manager").nixosConfigurations.hostname.options',
					},
					home_manager = {
						expr = '(builtins.getFlake "/tmp/NixOS_Home-Manager").homeConfigurations."user@hostname".options',
					},
					flake_parts = {
						expr = 'let flake = builtins.getFlake ("/tmp/NixOS_Home-Manager"); in flake.debug.options // flake.currentSystem.options',
					},
				},
			},

			-- See https://github.com/nvim-lua/kickstart.nvim/blob/748f67f49dd9fed47686d1d15e8566d2cba8ed35/init.lua#L750-L780
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						format = {
							enable = false,
						},
					},
				},
			},
		},
		config = function(plugin)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>ra", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/documentHighlight", event.buf) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local servers = plugin.spec.data.servers

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end

			vim.lsp.enable(vim.tbl_keys(servers) or {})
		end,
	},
}
