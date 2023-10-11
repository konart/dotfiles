return {
	"neovim/nvim-lspconfig",
	dependencies = { "mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<Leader>af", ":lua vim.lsp.buf.format()<CR>", silent = true },
		{ "]d", ":lua vim.diagnostic.goto_next({float=false})<CR>", silent = true },
		{ "[d", ":lua vim.diagnostic.goto_prev({float=false})<CR>", silent = true },
		{ "<Leader>la", ":lua vim.lsp.buf.code_action()<CR>", silent = true },
		{ "<Leader>lr", ":lua vim.lsp.buf.rename()<CR>", silent = true },
	},
	opts = {
		capabilities = {},
		servers = {
			--jsonls = {},
			gopls = {},
			tsserver = {},
			yamlls = {
				settings = {
					yaml = { keyOrdering = false },
				},
			},
			marksman = {},
			lua_ls = {
				-- mason = false, -- set to false if you don't want this server to be installed with mason
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			},
		},
		setup = {
			--["*"] = function(server, opts)
			--  require("lspconfig")[server].setup(opts)
			--end,
		},
	},
	config = function(_, opts)
		local servers = opts.servers
		local extended = require("cmp_nvim_lsp").default_capabilities()

		extended.textDocument.completion.completionItem.snippetSupport = true
		extended.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
				"actions",
			},
		}

		-- for ufo
		extended.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			-- require("cmp_nvim_lsp").default_capabilities(),
			extended,
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		local have_mason, mlsp = pcall(require, "mason-lspconfig")
		local all_mslp_servers = {}
		if have_mason then
			all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
		end

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		if have_mason then
			mlsp.setup({ ensure_installed = ensure_installed })
			mlsp.setup_handlers({ setup })
		end
	end,
}
