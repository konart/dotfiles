return {
	"gbprod/yanky.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		highlight = {
			timer = 150,
		}, -- refer to the configuration section below
	},
	config = function(_, opts)
		require("yanky").setup(opts)

		local ok, telescope = pcall(require, "telescope")
		if ok then
			telescope.load_extension("yank_history")

			require("yanky.telescope.mapping").put("p") -- put after cursor
			require("yanky.telescope.mapping").put("P") -- put before cursor
			require("yanky.telescope.mapping").put("gp") -- put after cursor and leave the cursor after
			require("yanky.telescope.mapping").put("gP") -- put before cursor and leave the cursor after
			require("yanky.telescope.mapping").delete() -- delete entry from yank history
		end

		local set = vim.keymap.set

		set({ "n", "x" }, "y", "<Plug>(YankyYank)")
		set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
		set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
	end,
}
