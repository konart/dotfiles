return {
	"s1n7ax/nvim-window-picker",
	version = "2.*",
	lazy = true,
	name = "window-picker",
	keys = {
		{
			"<leader>w",
			function()
				local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
				vim.api.nvim_set_current_win(picked_window_id)
			end,
			desc = "Pick a window",
		},
	},
	opts = function()
		local colors = require("ciapre.colors")
		return {
			hint = "floating-big-letter",
			picker_config = {
				statusline_winbar_picker = {
					use_winbar = "always",
				},
			},
			show_prompt = false,
			highlights = {
				winbar = {
					focused = {
						fg = colors.base.markup,
						bg = colors.base.blue,
						bold = true,
					},
					unfocused = {
						fg = colors.base.markup,
						bg = colors.base.blue,
						bold = true,
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("window-picker").setup(opts)
	end,
}
