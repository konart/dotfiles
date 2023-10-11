return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "mason.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local null_ls = require("null-ls")

		return {
			sources = {
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.formatting.jq,
			},
		}
	end,
	config = function(_, opts)
		require("null-ls").setup(opts)
	end,
}
