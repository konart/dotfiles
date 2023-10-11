return {
	"rcarriga/nvim-notify",
	keys = {
		{
			"<leader>n/",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Delete all Notifications",
		},
	},
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		stages = "slide",
		background_colour = "#ffffff",
	},
	init = function()
		vim.notify = require("notify")
	end,
}