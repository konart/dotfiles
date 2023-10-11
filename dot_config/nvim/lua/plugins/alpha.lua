return {
	"goolord/alpha-nvim",
	enabled=false,
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	opts = function()
		-- local if_nil = vim.F.if_nil
		local utils = require("utils.os")

		local default_header = {
			type = "text",
			val = {
				"",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣀⣠⣤⣤⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠴⠯⠭⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣶⣿⣿⣶⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠿⢯⣭⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⣛⣛⣻⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣭⣭⣭⣭⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣒⣒⣒⣲⣒⣒⣒⣻⣿⣿⣿⣟⣉⣭⣭⣭⣭⣭⣭⣭⣿⣿⣿⣟⣋⣭⣭⣭⣭⣽⣧⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣛⣛⣋⣉⡩⣭⣙⠻⣿⣿⣿⣿⢟⣋⡭⢭⣭⣝⢿⣿⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⠛⢞⣛⣶⣾⣿⣿⣿⣿⣧⡹⣿⣿⣿⣷⣾⢟⣡⣿⣿⡟⣯⠻⣿⣷⣾⡿⢋⣾⣿⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡟⣩⣤⣤⡌⡏⢸⡿⠋⣠⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠶⠾⠶⠄⢿⣿⣿⣿⣿⣿⣿⣿⣷⣮⣭⣽⣭⣥⣾⣿⣿⣿⡇⣿⣷⣭⣭⣭⣵⣾⣿⣿⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⡟⢰⣿⣿⣿⠇⡅⠈⠀⠾⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣀⣦⠘⣛⣚⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣧⡈⠛⢛⣡⣼⡇⢸⣿⣶⣌⣻⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡆⢙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡜⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠰⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⣭⡅⣤⡬⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣇⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣦⠙⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⠿⠟⢛⣛⣛⣛⣟⣛⣻⣻⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣟⣛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣟⣛⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣈⣙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠿⣿⣿⣿⣿⣿⣿⠿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⣶⣶⣄⣈⣛⣛⣛⣛⣛⣛⣫⣭⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⢼⢿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣦⣄⡀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠁⠽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢿⣿⣿⣌⢻⣧⡀⣤⡀⢀⣀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣐⣚⡓⠂⢻⣃⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣌⠻⣿⣿⣆⠻⠧⠹⠷⢼⣿⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠘⣛⣶⣶⡛⠿⠆⠐⠸⣿⡆⢈⡛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⣦⡌⢿⣿⣆⠀⠀⠀⠀⠈⢋⣵⣷⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣬⣭⣭⣤⣬⡍⠉⠁⠀⠀⠀⠀⢻⣷⠘⣿⣶⣬⣍⣛⣛⡛⠛⠛⢛⠋⣩⣴⣿⣿⣿⣌⠻⣿⣆⠀⠀⠀⢀⣼⣿⠟⢋⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣋⣙⠛⠿⣿⣿⣿⣆⠀⠀⠀⠀⣀⣼⠟⠈⣿⣿⣿⣿⣿⣿⠃⢘⠠⡆⣡⡌⣿⣿⣿⡿⢃⣶⣮⣍⣛⣛⣛⣛⣉⣤⣾⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⠀⠀⢠⣭⣭⣵⣤⣤⣍⠹⠿⠷⠶⠒⢚⣉⣭⣦⣶⣌⠻⢿⣿⣿⣿⣄⠸⣶⣶⣿⠃⣿⠛⣡⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠀⢠⠀⣺⣿⣿⣿⣿⣿⣿⣿⣷⡟⢻⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣦⡌⠁⣴⣿⠛⣿⣿⠈⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⢀⡎⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢘⡋⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢀⡘⠿⠿⠛⢋⣴⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⡟⣻⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⠀⠼⠆⠴⠾⠿⠿⢿⣿⣿⣿⣿⣿⣿⠈⢠⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣷⢐⠂⢸⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠘⣰⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⠀⣐⣛⡃⣚⣛⣛⣿⣿⣿⣿⣿⣿⣿⣿⠀⠇⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠈⣿⣿⠈⡃⢸⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣰⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"            ⠀⠀⠀⢐⣚⣒⡂⣒⣓⣶⣶⣿⣿⣿⣿⣿⣿⣏⣀⣐⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣿⣿⠐⠆⢸⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"",
			},
			opts = {
				position = "center",
				hl = "Type",
				-- wrap = "overflow";
			},
		}

		local function get_item(txt)
			local item_opts = {
				position = "center",
				-- shortcut = sc,
				cursor = 5,
				width = 50,
				align_shortcut = "right",
				hl_shortcut = "Keyword",
			}

			return {
				type = "text",
				val = txt,
				opts = item_opts,
			}
		end

		local git_root, ret = utils.get_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.loop.cwd())
		local footer_val = {}

		local function get_dashboard_git_status()
			local git_cmd = { "git", "status", "-s", "--", "." }
			local output = utils.get_command_output(git_cmd)
			-- set_var('dashboard_custom_footer', {'Git status', '', unpack(output)})
			local items = { "Git status", "", unpack(output) }
			for i, v in ipairs(items) do
				footer_val[i] = get_item(v)
			end
		end

		if ret ~= 0 then
			local is_worktree =
				utils.get_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, vim.loop.cwd())
			if is_worktree[1] == "true" then
				get_dashboard_git_status()
			else
				-- set_var('dashboard_custom_footer', {'Not in a git directory'})
				footer_val = { get_item("Not in a git directory") }
			end
		else
			get_dashboard_git_status()
		end

		local footer = {
			type = "group",
			val = footer_val,
			opts = {
				position = "center",
				hl = "Number",
			},
		}

		-- --- @param sc string
		-- --- @param txt string
		-- --- @param keybind string optional
		-- --- @param keybind_opts table optional
		-- local function button(sc, txt, keybind, keybind_opts)
		-- 	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
		--
		-- 	local opts = {
		-- 		position = "center",
		-- 		shortcut = sc,
		-- 		cursor = 5,
		-- 		width = 50,
		-- 		align_shortcut = "right",
		-- 		hl_shortcut = "Keyword",
		-- 	}
		-- 	if keybind then
		-- 		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		-- 		opts.keymap = { "n", sc_, keybind, keybind_opts }
		-- 	end
		--
		-- 	local function on_press()
		-- 		local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		-- 		vim.api.nvim_feedkeys(key, "normal", false)
		-- 	end
		--
		-- 	return {
		-- 		type = "button",
		-- 		val = txt,
		-- 		on_press = on_press,
		-- 		opts = opts,
		-- 	}
		-- end
		-- local buttons = {
		-- 	type = "group",
		-- 	val = {
		-- 		button("SPC g c", "🚚 Commits", ":Telescope git_commits <CR>"),
		-- 		button("SPC g m", "🔖 Bookmarks", ":Telescope marks <CR>"),
		-- 		button("SPC g h", "🕓 Recent files", ":Telescope oldfiles <CR>"),
		-- 		button("SPC g o", "📄 Find file", ":Telescope find_files <CR>"),
		-- 		button("SPC g f", "🔤 Find text", ":Telescope live_grep <CR>"),
		-- 	},
		-- 	opts = {
		-- 		spacing = 1,
		-- 	},
		-- }
		local section = {
			header = default_header,
			-- buttons = buttons,
			footer = footer,
		}

		return {
			layout = {
				{ type = "padding", val = 2 },
				section.header,
				{ type = "padding", val = 2 },
				-- section.buttons,
				section.footer,
			},
			opts = {
				margin = 5,
			},
		}
	end,
	config = function(_, opts)
		require("alpha").setup(opts)
	end,
}
