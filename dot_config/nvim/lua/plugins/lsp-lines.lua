return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	version = false,
	config = true,
	-- use even to something like than
	-- config = function()
	-- 	local excluded_fts = { "lazy" }
	-- 	if excluded_fts[vim.bo.filetype] == nil then
	-- 		require("lsp_lines").setup()
	-- 	end
	-- end,
}
