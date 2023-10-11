return {
	dir = "~/build/personal/ciapre.nvim",
	name = "Ciapre colorscheme",
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- does not work. figure out why (most likely have to define theme differently)
	init = function()
		require("ciapre")
		-- load the colorscheme here
		vim.cmd([[colorscheme ciapre]])
	end,
}
