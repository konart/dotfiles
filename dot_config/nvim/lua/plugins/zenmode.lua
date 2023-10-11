return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		window = {
			width = 180,
			options = {
				number = false,
			},
		},
	},
	config = function(_, opts)
		require("zen-mode").setup(opts)
	end,
}
