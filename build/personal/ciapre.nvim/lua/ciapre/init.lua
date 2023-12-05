local M = {}
local cmd = vim.cmd
local g = vim.g
-- local o = vim.o
local fn = vim.fn
local colors = require("ciapre.colors")

g.colors_name = "ciapre"

cmd("hi clear")

if fn.exists("syntax_on") then
	cmd("syntax reset")
end

function M.load_syntax()
	local function merge(first_table, second_table)
		for k, v in pairs(second_table) do
			first_table[k] = v
		end
		return first_table
	end

	local function invert(hl)
		local inverted = {}
		inverted.fg = colors.base.asphalt
		inverted.bg = hl.fg or colors.base.olive

		return inverted
	end

	local syntax = {}

	syntax["LspDiagnosticsDefaultErrorLine"] = { fg = colors.base.red, bg = colors.base.markup }
	syntax["LspReferenceText"] = { fg = colors.base.none, bg = colors.base.blue }
	syntax["LspReferenceRead"] = syntax["LspReferenceText"]
	syntax["LspReferenceWrite"] = syntax["LspReferenceText"]

	syntax["Cursor"] = { fg = colors.base.asphalt, bg = colors.base.markup }
	syntax["Visual"] = { fg = colors.base.none, bg = colors.base.blue }
	syntax["CursorLine"] = { fg = colors.base.none, bg = colors.base.dark }
	syntax["CursorLineNr"] = { fg = colors.base.none, bg = colors.base.none }
	syntax["CursorColumn"] = { fg = colors.base.none, bg = colors.base.dark }
	syntax["ColorColumn"] = { fg = colors.base.none, bg = colors.base.asphalt }
	syntax["LineNr"] = { fg = colors.base.olive, bg = colors.base.none }
	syntax["SignColumn"] = syntax["LineNr"]
	-- syntax['VertSplit']    = {fg=colors.mods.dirt, bg=colors.base.asphalt}
	syntax["VertSplit"] = { fg = colors.base.dark, bg = colors.base.dark }
	syntax["MatchParen"] = { fg = colors.base.redis, bg = colors.base.none, underline = true }
	syntax["StatusLineNC"] = { fg = colors.base.none, bg = colors.base.dark }
	syntax["StatusLine"] = { fg = colors.base.none, bg = colors.base.dark, bold = true } -- same as NC, except bold
	syntax["Pmenu"] = { fg = colors.base.none, bg = colors.base.dark }
	syntax["PmenuSel"] = { fg = colors.base.none, bg = colors.base.blue }
	syntax["Search"] = { fg = colors.base.none, bg = colors.base.brown }
	syntax["IncSearch"] = syntax["Search"]
	syntax["Directory"] = { fg = colors.base.redis, bg = colors.base.none }
	syntax["Folded"] = { fg = colors.base.gray, bg = colors.base.asphalt }
	syntax["FoldColumn"] = syntax["LineNr"]

	syntax["Normal"] = { fg = colors.base.markup, bg = colors.base.none }
	syntax["NormalFloat"] = { fg = colors.base.markup, bg = colors.base.dark }
	syntax["FloatBorder"] = syntax["NormalFloat"]
	syntax["NormalNC"] = { fg = colors.base.markup, bg = colors.base.dark }
	syntax["Boolean"] = { fg = colors.base.orange, bg = colors.base.none }
	syntax["Character"] = { fg = colors.base.redis, bg = colors.base.none }
	syntax["Comment"] = { fg = colors.base.gray, bg = colors.base.none, italic = true }
	syntax["Conceal"] = { fg = colors.base.gray, bg = colors.mods.ghost }
	syntax["Conditional"] = syntax["Character"]
	syntax["Constant"] = syntax["Character"]
	syntax["Define"] = syntax["Character"]
	syntax["DiffAdd"] = { fg = colors.mods.chalk, bg = colors.mods.grass }
	syntax["DiffDelete"] = { fg = "#561515", bg = colors.base.none }
	syntax["DiffChange"] = { fg = colors.mods.chalk, bg = colors.base.blue } -- compare with difftext
	syntax["DiffText"] = { fg = colors.mods.chalk, bg = colors.mods.ink }
	syntax["ErrorMsg"] = { fg = colors.base.white, bg = colors.base.red }
	syntax["WarningMsg"] = { fg = colors.base.white, bg = colors.base.yellow }
	syntax["Float"] = syntax["Character"]
	syntax["Function"] = { fg = colors.base.peach, bg = colors.base.none }
	syntax["Identifier"] = syntax["Character"]
	syntax["Keyword"] = syntax["Character"]
	syntax["String"] = { fg = colors.mods.fade, bg = colors.base.none }
	syntax["Label"] = syntax["String"]
	syntax["Text"] = syntax["Normal"]
	syntax["NonText"] = { fg = colors.mods.ghost, bg = colors.base.none }
	syntax["Whitespace"] = syntax["NonText"]
	syntax["Number"] = syntax["Character"]
	syntax["Operator"] = syntax["Character"]
	syntax["PreProc"] = syntax["Character"]
	syntax["Special"] = { fg = colors.mods.chalk, bg = colors.base.none }
	syntax["SpecialKey"] = syntax["Special"]
	syntax["Statement"] = syntax["Character"]
	syntax["StorageClass"] = syntax["Character"]
	syntax["Delimiter"] = syntax["Normal"]
	syntax["Tag"] = { fg = colors.mods.skin, bg = colors.base.none }
	syntax["Title"] = { fg = colors.mods.chalk, bg = colors.base.none, bold = true }
	syntax["Todo"] = { fg = colors.base.gray, bg = colors.base.none, bold = true, reverse = true }
	syntax["Type"] = { fg = colors.mods.sky, bg = colors.base.none }
	syntax["Underlined"] = { fg = colors.base.none, bg = colors.base.none, underline = true }

	-- NvimTree
	syntax["NvimTreeFolderIcon"] = { fg = colors.base.redis }
	syntax["NvimTreeIndentMarker"] = { fg = colors.base.redis }

	syntax["HopNextKey"] = { fg = colors.base.orange, bg = colors.base.blue }
	syntax["HopNextKey1"] = { fg = colors.base.peach, bg = colors.base.blue }
	syntax["HopNextKey2"] = { fg = colors.base.yellow, bg = colors.base.blue }
	syntax["HopUnmatched"] = { fg = colors.base.olive, bg = colors.base.asphalt }

	-- nvim-notify
	-- syntax["NotifyINFOBorder"] = { fg = colors.base.blue, bg = colors.base.asphalt }
	-- syntax["NotifyINFOTitle"] = { fg = colors.mods.sky, bg = colors.base.asphalt }
	-- syntax["NotifyINFOIcon"] = { fg = colors.mods.sky, bg = colors.base.asphalt }
	-- syntax["NotifyINFOBody"] = { fg = colors.base.markup, bg = colors.base.asphalt }
	--
	-- syntax["NotifyWARNBorder"] = { fg = colors.base.brown, bg = colors.base.asphalt }
	-- syntax["NotifyWARNTitle"] = { fg = colors.base.peach, bg = colors.base.asphalt }
	-- syntax["NotifyWARNIcon"] = { fg = colors.base.peach, bg = colors.base.asphalt }
	-- syntax["NotifyWARNBody"] = { fg = colors.base.markup, bg = colors.base.asphalt }
	--
	-- syntax["NotifyERRORBorder"] = { fg = colors.mods.blood, bg = colors.base.asphalt }
	-- syntax["NotifyERRORTitle"] = { fg = colors.base.red, bg = colors.base.asphalt }
	-- syntax["NotifyERRORIcon"] = { fg = colors.base.red, bg = colors.base.asphalt }
	-- syntax["NotifyERRORBody"] = { fg = colors.base.markup, bg = colors.base.asphalt }

	-- syntax['markdownHeadingDelimiter'] = { fg = colors.base.orange, style = "bold" }
	-- syntax['markdownCode'] = { fg = colors.base.olive }
	-- syntax['markdownCodeBlock'] = { fg = colors.base.olive }
	-- syntax['markdownH1'] = { fg = colors.base.orange, style = "bold" }
	-- syntax['markdownH2'] = { fg = colors.base.orange, style = "bold" }
	-- syntax['markdownLinkText'] = { fg = colors.base.blue, style = "underline" }

	syntax["TSAttribute"] = { fg = colors.base.blue, bg = colors.base.red }
	syntax["TSBoolean"] = syntax["Boolean"]
	syntax["@variable"] = syntax["Normal"]
	syntax["@property"] = syntax["Normal"]
	syntax["@field"] = syntax["@property"]
	syntax["@text.strong"] = { bold = true }
	syntax["@text.emphasis"] = { italic = true }
	syntax["@function.builtin"] = syntax["Function"]

	-- syntax['TSCharacter'] = syntax['Character']
	-- Character literals: `'a'` in C.

	-- syntax['TSComment'] = syntax['Comment']
	-- Line comments and block comments.

	-- syntax['TSConditional'] = syntax['Conditional']
	-- Keywords related to conditionals: `if`, `when`, `cond`, etc.

	-- syntax['TSConstant'] = syntax['Constant']
	-- Constants identifiers. These might not be semantically constant.
	-- E.g. uppercase variables in Python.

	-- syntax['TSConstBuiltin'] = syntax['Constant']
	-- Built-in constant values: `nil` in Lua.

	-- syntax['TSConstMacro'] = syntax['Constant']
	-- Constants defined by macros: `NULL` in C.

	-- syntax['TSConstructor'] = {fg=colors.base.dark, bg=colors.base.red}
	-- Constructor calls and definitions: `{}` in Lua, and Java constructors.

	-- syntax['TSError'] = {style='underline'}
	-- Syntax/parser errors. This might highlight large sections of code while the
	-- user is typing still incomplete code, use a sensible highlight.

	-- syntax['TSException'] = syntax['Keyword']
	-- Exception related keywords: `try`, `except`, `finally` in Python.

	-- syntax['TSField']
	-- Object and struct fields.

	-- syntax['TSFloat']
	-- Floating-point number literals.

	-- syntax['TSFunction']
	-- Function calls and definitions.

	-- syntax['TSFuncBuiltin']
	-- Built-in functions: `print` in Lua.

	-- syntax['TSFuncMacro']
	-- Macro defined functions (calls and definitions): each `macro_rules` in Rust.

	-- syntax['TSInclude']
	-- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.

	-- syntax['TSKeyword']
	-- Keywords that don't fit into other categories.

	-- syntax['TSKeywordFunction']
	-- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.

	-- syntax['TSKeywordOperator']
	-- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.

	-- syntax['TSKeywordReturn']
	-- Keywords like `return` and `yield`.

	-- syntax['TSLabel']
	-- GOTO labels: `label:` in C, and `::label::` in Lua.

	-- syntax['TSMethod']
	-- Method calls and definitions.

	-- syntax['TSNamespace']
	-- Identifiers referring to modules and namespaces.

	-- syntax['TSNone']
	-- No highlighting (sets all highlight arguments to `NONE`). this group is used
	-- to clear certain ranges, for example, string interpolations. Don't change the
	-- values of this highlight group.

	-- syntax['TSNumber']
	-- Numeric literals that don't fit into other categories.

	-- syntax['TSOperator']
	-- Binary or unary operators: `+`, and also `->` and `*` in C.

	-- syntax['TSParameter']
	-- Parameters of a function.

	-- syntax['TSParameterReference']
	-- References to parameters of a function.

	-- syntax['TSProperty']
	-- Same as `TSField`.

	-- syntax['TSPunctDelimiter']
	-- Punctuation delimiters: Periods, commas, semicolons, etc.

	-- syntax[`TSPunctBracket`]
	-- Brackets, braces, parentheses, etc.

	-- syntax['TSPunctSpecial']
	-- Special punctuation that doesn't fit into the previous categories.

	-- syntax['TSRepeat']
	-- Keywords related to loops: `for`, `while`, etc.

	-- syntax['TSString']
	-- String literals.

	-- syntax['TSStringRegex']
	-- Regular expression literals.

	-- syntax['TSStringEscape']
	-- Escape characters within a string: `\n`, `\t`, etc.

	-- syntax['TSStringSpecial']
	-- Strings with special meaning that don't fit into the previous categories.

	-- syntax['TSSymbol']
	-- Identifiers referring to symbols or atoms.

	-- syntax['TSTag'] = syntax['Function']
	syntax["TSTag"] = syntax["Tag"]
	-- Tags like HTML tag names.

	-- syntax['TSTagAttribute']
	-- HTML tag attributes.

	-- syntax['TSTagDelimiter']
	-- Tag delimiters like `<` `>` `/`.

	-- syntax['TSText']
	-- Non-structured text. Like text in a markup language.

	-- syntax['TSStrong']
	-- Text to be represented in bold.

	-- syntax['TSEmphasis']
	-- Text to be represented with emphasis.

	-- syntax['TSUnderline']
	-- Text to be represented with an underline.

	-- syntax['TSStrike']
	-- Strikethrough text.

	syntax["TSTitle"] = syntax["Title"]
	-- Text that is part of a title.

	-- syntax['TSLiteral']
	-- Literal or verbatim text.

	syntax["TSURI"] = { fg = colors.mods.sky, underline = true }
	-- URIs like hyperlinks or email addresses.

	-- syntax['TSMath']
	-- Math environments like LaTeX's `$ ... $']

	-- syntax['TSTextReference'] = merge(syntax['Comment'], {style='italic'})
	-- syntax['TSTextReference'] = {fg='#ffffff',bg='#222222',style='underline'}
	-- Footnotes, text references, citations, etc.

	-- syntax['TSEnvironment']
	-- Text environments of markup languages.

	-- syntax['TSEnvironmentName']
	-- Text/string indicating the type of text environment. Like the name of a syntax['\begin` block in LaTeX.

	-- syntax['TSNote']
	-- Text representation of an informational note.

	-- syntax['TSWarning']
	-- Text representation of a warning note.

	-- syntax['TSDanger']
	-- Text representation of a danger note.

	-- syntax['TSType']
	-- Type (and class) definitions and annotations.

	-- syntax['TSTypeBuiltin']
	-- Built-in types: `i32` in Rust.

	-- syntax['TSVariable']
	-- Variable names that don't fit into other categories.

	-- syntax['TSVariableBuiltin']
	-- Variable names defined by the language: `this` or `self` in Javascript.

	--  Module = 9,
	--  Unit = 11,
	--  Value = 12,
	--  Enum = 13,
	--  Color = 16,
	--  Reference = 18,
	--  EnumMember = 20,
	--  Event = 23,
	--  TypeParameter = 25,

	syntax["CmpItemKindFunction"] = invert(syntax["Function"])
	syntax["CmpItemKindMethod"] = { link = "CmpItemKindFunction" }
	syntax["CmpItemKindConstant"] = invert(syntax["Constant"])
	syntax["CmpItemKindClass"] = invert(syntax["Type"])
	syntax["CmpItemKindInterface"] = { link = "CmpItemKindClass" }
	syntax["CmpItemKindStruct"] = { link = "CmpItemKindClass" }
	syntax["CmpItemKindText"] = invert(syntax["Normal"])
	syntax["CmpItemKindConstructor"] = invert(syntax["Keyword"])
	syntax["CmpItemKindField"] = invert(syntax["@field"])
	syntax["CmpItemKindProperty"] = { link = "CmpItemKindField" }
	syntax["CmpItemKindVariable"] = invert(syntax["@variable"])
	syntax["CmpItemKindKeyword"] = invert(syntax["Keyword"])
	syntax["CmpItemKindSnippet"] = { link = "CmpItemKindText" }
	syntax["CmpItemKindFile"] = { link = "CmpItemKindText" }
	syntax["CmpItemKindFolder"] = { link = "CmpItemKindText" }
	syntax["CmpItemKindOperator"] = invert(syntax["Operator"])
	syntax["CmpItemKindModule"] = invert(syntax["String"])
	syntax["PmenuThumb"] = { fg = colors.base.none, bg = colors.base.gray }
	syntax["PmenuSbar"] = { fg = colors.base.none, bg = colors.base.asphalt }
	syntax["MiniIndentscopeSymbol"] ={ fg = colors.base.red, bg = colors.base.asphalt }

	for group, highlights in pairs(syntax) do
		vim.api.nvim_set_hl(0, group, highlights)
	end
end

M.load_syntax()
