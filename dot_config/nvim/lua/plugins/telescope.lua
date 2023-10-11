return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "natecraddock/telescope-zf-native.nvim" },
	cmd = "Telescope",
	keys = {
		{ "<Leader>go",  ":Telescope fd<CR>",                                                   silent = true },
		{ "<Leader>gi",  ":Telescope lsp_implementations<CR>",                                  silent = true },
		{ "<Leader>gs",  ":Telescope lsp_document_symbols<CR>",                                 silent = true },
		{ "<Leader>gr",  ":Telescope lsp_references<CR>",                                       silent = true },
		{ "<Leader>gic", ":Telescope lsp_incoming_calls<CR>",                                   silent = true },
		{ "<Leader>gf",  ":Telescope live_grep<CR>",                                            silent = true },
		-- { "<Leader>gb",  ":Telescope buffers<CR>",              silent = true },
		{ "<Leader>gb",  ":lua require('telescope.builtin').buffers({sort_lastused=true})<CR>", silent = true },
		{
			"<Leader>gdv",
			'<cmd>lua require("telescope.builtin").lsp_definitions({jump_type="vsplit", reuse_win=true})<CR>',
			silent = true,
		},
		{
			"<Leader>gdh",
			'<cmd>lua require("telescope.builtin").lsp_definitions({jump_type="split"})<CR>',
			silent = true,
		},
		{
			"<Leader>gdn",
			'<cmd>lua require("telescope.builtin").lsp_definitions()<CR>',
			silent = true,
		},
		{
			"<Leader>gtdv",
			'<cmd>lua require("telescope.builtin").lsp_type_definitions({jump_type="vsplit"})<CR>',
			silent = true,
		},
		{
			"<Leader>gtdh",
			'<cmd>lua require("telescope.builtin").lsp_type_definitions({jump_type="split"})<CR>',
			silent = true,
		},
		{
			"<Leader>gtdn",
			'<cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>',
			silent = true,
		},
	},
	opts = {
		defaults = {
			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = " ",
			-- border = false,
			mappings = {
				-- i = { ["<c-t>"] = telescope_provider.open_with_trouble },
				-- n = { ["<c-t>"] = telescope_provider.open_with_trouble },
			},
		},
	},
	config = function(_, opts)
		local colors = require("ciapre.colors")

		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.base.black, bg = colors.base.black })
		vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.base.black, bg = colors.base.markup })
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { fg = colors.base.markup, bg = colors.base.black })

		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.base.asphalt, bg = colors.base.asphalt })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.base.black, bg = colors.base.markup })
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { fg = colors.base.markup, bg = colors.base.asphalt })

		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.base.peach, bg = colors.base.none })

		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.mods.dirt, bg = colors.mods.dirt })
		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.base.black, bg = colors.base.olive })
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = colors.base.markup, bg = colors.mods.dirt })
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = colors.base.markup, bg = colors.mods.dirt })

		require("telescope").setup(opts)

		require("telescope").load_extension("zf-native")
	end,
}
