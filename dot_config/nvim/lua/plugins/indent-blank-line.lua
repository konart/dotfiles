return {
	-- "lukas-reineke/indent-blankline.nvim",
	-- dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- event = { "BufReadPost", "BufNewFile" },
	-- version = "2.20.8",
	-- opts = {
	-- 	char = "o",
	-- 	use_treesitter = true,
	-- 	-- filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
	-- 	show_trailing_blankline_indent = false,
	-- 	show_current_context = false,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = { tab_char = "│" },
				scope = { enabled = false },
			})
		end,
	},
}
