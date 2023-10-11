-- watch for https://github.com/neovim/neovim/pull/13479
-- should replace things in globals
local opt = vim.opt
local cmd = vim.cmd

-- fix fish shell lags for nvim-tree
opt.shell = "/bin/bash"

-- colorscheme
opt.termguicolors = true
opt.cursorline = true
opt.background = "dark"
-- local ok, _ = pcall(require, "ciapre")
-- if ok then
-- 	cmd([[colorscheme ciapre]])
-- end

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

local function list(value, str, sep)
	sep = sep or ","
	str = str or ""
	value = type(value) == "table" and table.concat(value, sep) or value
	return str ~= "" and table.concat({ value, str }, sep) or value
end

-- Settings
opt.signcolumn = "no"
opt.updatetime = 200
opt.timeoutlen = 300 -- whichkey

opt.laststatus = 3
opt.fillchars = list({
	"vert:│",
	"diff:╱",
	"foldsep: ",
	"foldclose:",
	"foldopen:",
	"msgsep:─",
})
opt.diffopt = list({
	"algorithm:histogram",
	"internal",
	"indent-heuristic",
	"filler",
	"closeoff",
	"iwhite",
	"vertical",
})
opt.showtabline = 0
opt.hidden = true -- hide a buffer instead of closing
opt.cmdheight = 2 -- Better display for messages
-- can this be done via opt?
cmd([[set shortmess+=c]]) -- Don't pass messages to ins-completion-menu
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.number = true
opt.relativenumber = true
opt.linebreak = true
opt.showbreak = "+++"
opt.textwidth = 100
opt.showmatch = true
opt.visualbell = true
opt.formatoptions = "jql"
opt.scrolloff = 15
opt.pb = 0

opt.hlsearch = true
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.ignorecase = true

opt.autoindent = true
opt.shiftwidth = 4
opt.softtabstop = 2

opt.ruler = true
opt.splitbelow = true
opt.splitright = true

-- opt.nobackup = true, window
-- opt.nowritebackup = true

opt.undolevels = 1000
opt.backspace = "indent,eol,start"
opt.list = true
opt.listchars:append("space:·")
opt.listchars:append("eol:↴")
opt.listchars:append("tab:│->")
opt.listchars:append("trail:·")
opt.listchars:append("extends:…")
opt.listchars:append("precedes:…")

opt.clipboard = "unnamedplus"

opt.conceallevel = 3

opt.langmenu = "en_US"

vim.diagnostic.config({
	virtual_text = true,
})

-- TODO: fix append
cmd([[set errorformat^=%A%f:%l:%c:\ %m\ (%o),%-G%.%#]])
-- opt.errorformat:prepend([[%A%f:%l:%c:\ %m\ (%o),%-G%.%#]])

-- rust diag:
-- Diagnostic { code: RustcHardError("E0308"), message: "expected i32, found ()", range: 1291..1292, severity: Error, unused: false, experimental: true, fixes: None, main_node: None }
-- opt.errorformat = [[%ADiagnostic { code: %o\, message: "%m"\, range: %l..%c%.%#]]

local fn = vim.fn

function _G.qftf(info)
	local items
	local ret = {}
	-- The name of item in list is based on the directory of quickfix window.
	-- Change the directory for quickfix window make the name of item shorter.
	-- It's a good opportunity to change current directory in quickfixtextfunc :)
	--
	-- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
	-- local root = getRootByAlterBufnr(alterBufnr)
	-- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
	--
	if info.quickfix == 1 then
		items = fn.getqflist({ id = info.id, items = 0 }).items
	else
		items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
	end
	local limit = 36
	local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
	local validFmt = "󰈙 %s │%5d:%-3d│%s %s"
	local validModuleFmt = "[%12s] | " .. validFmt
	for i = info.start_idx, info.end_idx do
		local e = items[i]
		local fname = ""
		local str
		if e.valid == 1 then
			if e.bufnr > 0 then
				fname = fn.bufname(e.bufnr)
				if fname == "" then
					fname = "[No Name]"
				else
					fname = fname:gsub("^" .. vim.env.HOME, "~")
				end
				-- char in fname may occur more than 1 width, ignore this issue in order to keep performance
				if #fname <= limit then
					fname = fnameFmt1:format(fname)
				else
					fname = fnameFmt2:format(fname:sub(1 - limit))
				end
			end
			local lnum = e.lnum > 99999 and -1 or e.lnum
			local col = e.col > 999 and -1 or e.col
			local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
			if e.module ~= "" then
				str = validModuleFmt:format(e.module, fname, lnum, col, qtype, e.text)
			else
				str = validFmt:format(fname, lnum, col, qtype, e.text)
			end
		else
			str = e.text
		end
		table.insert(ret, str)
	end
	return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
