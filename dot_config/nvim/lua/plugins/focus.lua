return {
	"beauwilliams/focus.nvim",
	cmd = { "FocusSplitNicely", "FocusSplitCycle", "FocusToggle" },
	opts = {
		ui = {
			hybridnumber = true,
		},
	},
	config = function(_, opts)
		require("focus").setup(opts)
	end,
}
