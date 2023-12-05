return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = { "L3MON4D3/LuaSnip" },
		},
		"onsails/lspkind-nvim",
	},
	opts = function()
		local cmp = require("cmp")
		local str = require("cmp.utils.str")
		local types = require("cmp.types")
		local lspkind = require("lspkind")

		return {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			-- mapping = {
			--   ['<C-p>'] = cmp.mapping.select_prev_item(),
			--   ['<C-n>'] = cmp.mapping.select_next_item(),
			--   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			--   ['<C-f>'] = cmp.mapping.scroll_docs(4),
			--   ['<C-Space>'] = cmp.mapping.complete(),
			--   ['<C-e>'] = cmp.mapping.close(),
			--   ['<CR>'] = cmp.mapping.confirm({
			--     behavior = cmp.ConfirmBehavior.Insert,
			--     select = true,
			--   }),
			-- },

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			}),
			formatting = {
				fields = {
					cmp.ItemField.Kind,
					cmp.ItemField.Abbr,
					cmp.ItemField.Menu,
				},
				format = lspkind.cmp_format({
					before = function(entry, vim_item)
						-- Get the full snippet (and only keep first line)
						local word = entry:get_insert_text()
						if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
							word = vim.lsp.util.parse_snippet(word)
						end

						word = str.oneline(word)

						if
							entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
							and string.sub(vim_item.abbr, -1, -1) == "~"
						then
							word = word .. "~"
						end

						vim_item.abbr = word
						vim_item.menu = vim_item.kind

						vim_item.kind = lspkind.symbol_map[vim_item.kind] .. " "

						return vim_item
					end,
				}),
			},
			view = {
				entries = "custom",
			},
			window = {
				completion = {
					side_padding = 0,
					col_offset = 1,
				},
			},

			sources = {
				{ name = "nvim_lsp" },
				-- { name = "nvim_lsp_signature_help" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				-- { name = "luasnip" },
			},
			experimental = {
				ghost_text = true,
			},
			preselect = cmp.PreselectMode.Item,
			sorting = {
				comparators = {
					-- function(...)
					-- 	return cmp_buffer:compare_locality(...)
					-- end,
					cmp.config.compare.kind,
					cmp.config.compare.score,
					cmp.config.compare.offset,
					-- cmp.config.compare.exact,
					-- cmp.config.compare.sort_text,
					-- cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}
	end,
}
