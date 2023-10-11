return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<Leader>s", "<cmd>lua require('spectre').toggle()<CR>", silent = true },
	}
}
