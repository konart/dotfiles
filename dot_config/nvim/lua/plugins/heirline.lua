return {
	"rebelot/heirline.nvim",
	opts = function()
		local colors = require("ciapre.colors")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local frame_space = { left = " ", right = " " }
		local put_into_frame = function(text, frame)
			return frame.left .. text .. frame.right
		end

		local ViMode = {
			-- get vim current mode, this information will be required by the provider
			-- and the highlight functions, so we compute it only once per component
			-- evaluation and store it as a component attribute
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()

				-- execute this only once, this is required if you want the ViMode
				-- component to be updated on operator pending mode
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", { command = "redrawstatus" })
					self.once = true
				end
			end,
			-- Now we define some dictionaries to map the output of mode() to the
			-- corresponding string and color. We can put these into `static` to compute
			-- them at initialisation time.
			static = {
				mode_names = {
					-- change the strings if you like it vvvvverbose!
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = { bg = colors.base.markup, fg = colors.base.asphalt },
					i = { bg = colors.mods.skin, fg = colors.base.asphalt },
					v = { bg = colors.base.blue, fg = colors.base.markup },
					V = { bg = colors.base.blue, fg = colors.base.markup },
					c = { bg = colors.base.peach, fg = colors.base.asphalt },
					s = { bg = colors.base.markup, fg = colors.base.asphalt },
					S = { bg = colors.base.markup, fg = colors.base.asphalt },
					r = { bg = colors.base.yellow, fg = colors.base.asphalt },
					R = { bg = colors.base.yellow, fg = colors.base.asphalt },
					t = { bg = colors.base.markup, fg = colors.base.asphalt },
					["!"] = { bg = colors.base.markup, fg = colors.base.asphalt },
					["\19"] = { bg = colors.base.markup, fg = colors.base.asphalt },
					["\22"] = { bg = colors.base.markup, fg = colors.base.asphalt },
				},
			},
			-- We can now access the value of mode() that, by now, would have been
			-- computed by `init()` and use it to index our strings dictionary.
			-- note how `static` fields become just regular attributes once the
			-- component is instantiated.
			-- To be extra meticulous, we can also add some vim statusline syntax to
			-- control the padding and make sure our string is always at least 2
			-- characters long. Plus a nice Icon.
			{
				provider = function(self)
					return put_into_frame(self.mode_names[self.mode], frame_space)
				end,
				-- Same goes for the highlight. Now the foreground will change according to the current mode.
				hl = function(self)
					local mode = self.mode:sub(1, 1) -- get only the first mode character
					return { fg = self.mode_colors[mode].fg, bg = self.mode_colors[mode].bg }
				end,
			},
			{
				provider = "",
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode].bg, bg = colors.mods.dirt }
				end,
			},
			-- Re-evaluate the component only on ModeChanged event!
			-- This is not required in any way, but it's there, and it's a small
			-- performance improvement.
			-- update = "ModeChanged",
		}

		local Tab = {
			hl = { fg = colors.base.markup, bg = colors.mods.dirt },
			{
				provider = function()
					local sign = ""
					if vim.o.paste then
						sign = ""
					else
						sign = "󰮸"
					end
					return put_into_frame(sign, frame_space)
				end,
			},
			{
				provider = function()
					vim.cmd("match none /\t/")

					-- mixed indent (spaces and tabs)
					if vim.fn.search([[\v(^\t+)]], "nw") ~= 0 and vim.fn.search([[\v(^ +)]], "nw") ~= 0 then
						if vim.bo.filetype ~= "help" then
							vim.cmd("match ErrorMsg /\t/")
						end
						return put_into_frame("", frame_space)
					end

					-- trailing spaces
					if vim.fn.search("\\s$", "nw") ~= 0 then
						return put_into_frame("󰞗", frame_space)
					end

					return put_into_frame("󰮸", frame_space)
				end,
			},
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			hl = { fg = colors.base.markup, bg = colors.base.asphalt },
			{
				-- git branch name
				provider = function(self)
					return put_into_frame(" " .. self.status_dict.head, frame_space)
				end,
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "[",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and put_into_frame("+" .. count, frame_space)
				end,
				hl = { fg = colors.base.yellow },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and put_into_frame("-" .. count, frame_space)
				end,
				hl = { fg = colors.base.red },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and put_into_frame("~" .. count, frame_space)
				end,
				hl = { fg = colors.mods.ink },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "]",
			},
		}

		local FileNameBlock = {
			-- let's first set up some attributes needed by this component and it's children
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			hl = { bg = colors.base.dark },
		}
		-- We can now define some children separately and add them later

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		-- TODO: on HELP filetype to show statusline trick (ala feline)
		local FileName = {
			provider = function()
				local filename = vim.fn.expand("%:F")
				filename = filename ~= "" and filename or "[No Name]"
				if not conditions.width_percent_below(#filename, 0.5) then
					filename = vim.fn.expand("%:t")
				end
				return filename
			end,
			hl = { fg = utils.get_highlight("Directory").fg },
		}

		local FileFlags = {
			{
				provider = function()
					if vim.bo.modified then
						return "[+]"
					end
				end,
				hl = { fg = colors.mods.grass },
			},
			{
				provider = function()
					if not vim.bo.modifiable or vim.bo.readonly then
						return ""
					end
				end,
				hl = { fg = colors.mods.blood },
			},
		}

		-- Now, let's say that we want the filename color tochange if the buffer is
		-- modified. Of course, we could do that directly using the FileName.hl field,
		-- but we'll see how easy it is to alter existing components using a "modifier"
		-- component

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					-- use `force` because we need to override the child's hl foreground
					-- return { fg = colors.mods.ink, bold = true, force = true }
					return { bold = true, force = true }
				end
			end,
		}

		-- let's add the children to our FileNameBlock component
		FileNameBlock = utils.insert(
			FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			unpack(FileFlags),              -- A small optimisation, since their parent does nothing
			{ provider = "%<" }             -- this means that the statusline is cut here when there's not enough space
		)

		local LSPActive = {
			condition = conditions.lsp_attached,
			-- You can keep it simple,
			-- provider = " [LSP]",

			-- Or complicate things a bit and get the servers names
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.buf_get_clients(0)) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = colors.base.markup, bg = colors.base.asphalt },
		}
		-- local FileType = {
		--      provider = function()
		--              return vim.bo.filetype
		--      end,
		--      hl = { fg = utils.get_highlight("Type").fg },
		-- }
		local FileData = { hl = { bg = colors.mods.dirt } }
		local FileEncoding = {
			provider = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc,
		}
		local FileFormat = {
			provider = vim.bo.fileformat,
		}
		local Space = { provider = " " }
		FileData = utils.insert(FileData, FileEncoding, Space, FileFormat)

		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			provider = "%3l/%0L : %03c",
			hl = { bg = colors.base.olive },
		}

		local statusline = {
			ViMode,
			Tab,
			{ provider = "", hl = { fg = colors.mods.dirt, bg = colors.base.asphalt } },
			Git,
			{ provider = "", hl = { fg = colors.base.asphalt, bg = colors.base.dark } },
			utils.surround({ "%=", "%=" }, nil, FileNameBlock),
			{ provider = "", hl = { fg = colors.base.asphalt, bg = colors.base.dark } },
			LSPActive,
			{ provider = "", hl = { fg = colors.mods.dirt, bg = colors.base.asphalt } },
			FileData,
			{ provider = "", hl = { fg = colors.base.olive, bg = colors.mods.dirt } },
			Ruler,
		}

		local gitsigns_bar = "▌"
		-- local gitsigns_bar = "▎"

		local gitsigns_hl_pool = {
			GitSignsAdd = "GitSignsAdd",
			GitSignsChange = "GitSignsChange",
			GitSignsChangedelete = "GitSignsCDelete",
			GitSignsDelete = "GitSignsDelete",
			GitSignsTopdelete = "GitSignsTDelete",
			GitSignsUntracked = "GitSignsAdd", -- "NonText"
		}

		local diag_signs_icons = {
			DiagnosticSignError = " ",
			DiagnosticSignWarn = " ",
			DiagnosticSignInfo = "󰋽 ",
			DiagnosticSignHint = "󰄬 ",
			DiagnosticSignOk = "󰛩 ",
		}

		local function get_sign_name(cur_sign)
			if cur_sign == nil then
				return nil
			end

			cur_sign = cur_sign[1]

			if cur_sign == nil then
				return nil
			end

			cur_sign = cur_sign.signs

			if cur_sign == nil then
				return nil
			end

			cur_sign = cur_sign[1]

			if cur_sign == nil then
				return nil
			end

			return cur_sign["name"]
		end

		local function mk_hl(group, sym)
			return table.concat({ "%#", group, "#", sym, "%*" })
		end

		local function get_name_from_group(bufnum, lnum, group)
			local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
				group = group,
				lnum = lnum,
			})

			return get_sign_name(cur_sign_tbl)
		end

		_G.get_statuscol_gitsign = function(bufnr, lnum)
			local cur_sign_nm = get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

			if cur_sign_nm ~= nil then
				return mk_hl(gitsigns_hl_pool[cur_sign_nm], gitsigns_bar)
			else
				return " "
			end
		end

		_G.get_statuscol_diag = function(bufnum, lnum)
			local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

			if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
				vim.fn.sign_define(cur_sign_nm, { texthl = cur_sign_nm, text = "", numhl = cur_sign_nm })
				return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
			else
				return " "
			end
		end

		_G.set_statuscol_diag = function(bufnum, lnum)
			local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

			if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
				vim.fn.sign_define(cur_sign_nm, { texthl = cur_sign_nm, text = "", numhl = cur_sign_nm })
			end

			return ""
		end

		_G.get_statuscol = function()
			local str_table = {}

			local parts = {
				["diagnostics"] = "%{%v:lua.set_statuscol_diag(bufnr(), v:lnum)%}",
				["fold"] = "%C",
				["gitsigns"] = "%{%v:virtnum?'':v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
				["num"] = "%{v:virtnum?'':v:relnum?v:relnum:v:lnum}",
				["sep"] = "%=",
				["signcol"] = "%s",
				["space"] = " ",
			}

			local order = {
				"diagnostics",
				"sep",
				"num",
				"space",
				"gitsigns",
				"fold",
				-- "space",
			}

			for _, val in ipairs(order) do
				table.insert(str_table, parts[val])
			end

			return table.concat(str_table)
		end

		local statusless = { NvimTree = "", alpha = "", packer = "", fugitive = "", help = "", toggleterm = "" }
		statusless["neo-tree"] = ""

		return {
			statusline = statusline,
			-- statuscolumn = {
			-- 	provider = function()
			-- 		if statusless[vim.bo.filetype] ~= nil then
			-- 			return ""
			-- 		else
			-- 			return _G.get_statuscol()
			-- 		end
			-- 	end,
			-- },
		}
	end,
	config = function(_, opts)
		require("heirline").setup(opts)
	end,
}
