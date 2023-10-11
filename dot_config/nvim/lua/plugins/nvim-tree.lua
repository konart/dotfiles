return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "\\[", ":NvimTreeToggle<CR>", { silent = true } },
		{ "\\g", ":NvimTreeFindFile<CR>", { silent = true } },
	},
	opts = {
		filters = {
			custom = { "^node_modules$", "^.git$" },
		},
		update_focused_file = {
			enable = true,
		},
		view = {
			width = 35,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			highlight_git = true,
			special_files = { "go.mod", "go.sum", "README.md", "readme.md", "Dockerfile", "docker-compose.yml" },
			icons = { glyphs = { folder = { arrow_closed = "", arrow_open = "" } } },
		},
		git = {
			ignore = false,
		},
		diagnostics = {
			enable = true,
		},
		actions = {
			open_file = {
				window_picker = {
					enable = true,
					picker = function()
						return require("window-picker").pick_window(require("plugins.nvim-window-picker").opts())
					end,
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,
}
