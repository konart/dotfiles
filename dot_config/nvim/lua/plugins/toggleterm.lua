return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		shell = "fish",
		open_mapping = "\\t",
	},
	keys = { "\\t" },
	config = function(_, opts)
		require("toggleterm").setup(opts)
	end,
}
