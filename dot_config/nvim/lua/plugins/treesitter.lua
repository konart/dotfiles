return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"comment",
			"cpp",
			"css",
			"go",
			"gomod",
			"gosum",
			"html",
			"javascript",
			"json",
			"sql",
			"jsonc",
			"lua",
			"python",
			"ruby",
			"regex",
			"rust",
			"toml",
			"typescript",
			"yaml",
			"markdown",
			"markdown_inline",
		},
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		indent = { enable = false },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
