return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "Gitsigns" },
	opts = {
		signs = {
			add = { text = "▌", hl = "GitSignsAdd" },
			change = { text = "▌", hl = "GitSignsChange" },
			delete = { text = "▌", hl = "GitSignsDelete" },
			topdelete = { text = "▌", hl = "GitSignsTDelete" },
			changedelete = { text = "▌", hl = "GitSignsCDelete" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })
			-- map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
			-- map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

			-- Actions
			map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
			map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hu", gs.undo_stage_hunk)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end)
			map("n", "<leader>tb", gs.toggle_current_line_blame)
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>td", gs.toggle_deleted)

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end, -- sign_priority = 100
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)

		local colors = require("ciapre.colors")

		local highlighter = function(group, color)
			-- setup funtion
			color.guisp = color.guisp or "none"
			color.style = color.style or "none"
			color.bg = color.bg or "none"
			local g_foreground = color.fg
			local g_background = color.bg
			vim.cmd(string.format("hi %s guifg=%s guibg=%s", group, g_foreground, g_background))
		end

		local load_syntax = function()
			local syntax = {}

			syntax["GitSignsAdd"] = { fg = colors.mods.grass, bg = colors.base.none }
			syntax["GitSignsChange"] = { fg = colors.mods.sky, bg = colors.base.none }
			syntax["GitSignsDelete"] = { fg = colors.mods.blood, bg = colors.base.none }
			syntax["GitSignsTDelete"] = { fg = colors.mods.blood, bg = colors.base.white }
			syntax["GitSignsCDelete"] = { fg = colors.mods.blood, bg = colors.base.olive }

			for group, highlights in pairs(syntax) do
				highlighter(group, highlights)
			end
		end

		load_syntax()
	end,
}
