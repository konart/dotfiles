return {
	"windwp/nvim-autopairs",
	dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
	event = "InsertEnter",
	opts = {
		ignored_next_char = "[%w%.]",
		check_ts = true,
		ts_config = {
			lua = { "string" }, -- it will not add pair on that treesitter node
			javascript = { "string" },
		},
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cmp = require("cmp")
		local handlers = require("nvim-autopairs.completion.handlers")

		npairs.setup(opts)

		local ts_conds = require("nvim-autopairs.ts-conds")

		-- press % => %% is only inside comment or string
		npairs.add_rules({
			Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
			Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on(
			"confirm_done",
			cmp_autopairs.on_confirm_done({
				filetypes = {
					go = {
						["{"] = {
							kind = {
								cmp.lsp.CompletionItemKind.Struct,
							},
							handler = handlers["*"],
							-- handler = function(char, item, bufnr, rules, commit_character)
							-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
							-- print(vim.inspect({ char, item, bufnr, rules, commit_character }))
							-- end,
						},
					},
				},
			})
		)
	end,
}
