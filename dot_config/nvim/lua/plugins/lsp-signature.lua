return {
	"ray-x/lsp_signature.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		floating_window_above_cur_line = true,
		floating_window_off_y = -2,
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}
