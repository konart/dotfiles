return {
	"luukvbaal/statuscol.nvim",
	opts = function()
		local builtin = require("statuscol.builtin")

		local function mk_hl(group, sym)
			return table.concat({ "%#", group, "#", sym, "%*" })
		end

		local function get_signs(buf, lnum)
			return vim.tbl_map(function(sign)
				return vim.fn.sign_getdefined(sign.name)[1]
			end, vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs)
		end

		local function get_sign(name, sign_func, show_empty)
			return function(args, fa)
				local sign = sign_func(args, fa)
				for _, i in ipairs(get_signs(args.buf, args.lnum)) do
					if i.name:find(name) then
						return mk_hl(i.texthl, sign)
					end
				end
				return show_empty and sign or " "
			end
		end

		local function get_extmark_sing(ns, sign_func, show_empty)
			return function(args)
				local sign = sign_func(args)
				for name, id in pairs(vim.api.nvim_get_namespaces()) do
					if name == ns then
						local all = vim.api.nvim_buf_get_extmarks(
							args.buf,
							id,
							{ args.lnum - 1, 0 },
							-1,
							{ details = true }
						)
						for _, mark in ipairs(all) do
							if mark[2] + 1 == args.lnum then
								return mk_hl(mark[4].sign_hl_group, sign)
							end
						end
					end
				end
				return show_empty and sign or " "
			end
		end

		return {
			ft_ignore = { "NvimTree", "neo-tree", "alpha", "lazy", "fugitive", "help", "toggleterm" },
			relculright = true,
			segments = {
				-- { text = { " " } },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				-- { text = { colorify("DiagnosticSign", builtin.lnumfunc), " " }, click = "v:lua.ScLa" },
				{
					text = { get_sign("DiagnosticSign", builtin.lnumfunc, true) },
				},
				{ text = { " " } },
				{
					text = {
						get_extmark_sing("gitsigns_extmark_signs_", function()
							return "▌"
						end, false),
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("statuscol").setup(opts)
	end,
}
