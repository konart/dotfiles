return {
	"phaazon/hop.nvim",
	enabled = false,
	version = "v2.x",
	-- event = { "BufReadPre", "BufNewFile" },
	-- keys = function()
	-- 	local hop = require("hop")
	-- 	local directions = require("hop.hint").HintDirection
	-- 	return {
	-- 		{
	-- 			"f",
	-- 			function()
	-- 				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	-- 			end,
	-- 		},
	-- 		{
	-- 			"ff",
	-- 			function()
	-- 				hop.hint_char1({ direction = directions.AFTER_CURSOR })
	-- 			end,
	-- 		},
	-- 		{
	-- 			"F",
	-- 			function()
	-- 				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	-- 			end,
	-- 		},
	-- 		{
	-- 			"FF",
	-- 			function()
	-- 				hop.hint_char1({ direction = directions.BEFORE_CURSOR })
	-- 			end,
	-- 		},
	-- 	}
	-- end,
	config = function()
		require("hop").setup()
		local set = vim.keymap.set
		set("n", ",w", '<cmd>lua require("hop").hint_words()<cr>', { silent = true })
		set("n", ",cc", '<cmd>lua require("hop").hint_char2()<cr>', { silent = true })
		set("n", ",l", '<cmd>lua require("hop").hint_lines()<cr>', { silent = true })
	end,
}
