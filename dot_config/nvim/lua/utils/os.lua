-- Stolen from https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/utils.lua#L409
local Job = require("plenary.job")

local os = {}

function os.get_command_output(cmd, cwd)
	if type(cmd) ~= "table" then
		print("[get_command_output]: cmd has to be a table")
		return {}
	end
	local command = table.remove(cmd, 1)
	local stderr = {}
	local stdout, ret = Job:new({
		command = command,
		args = cmd,
		cwd = cwd,
		on_stderr = function(_, data)
			table.insert(stderr, data)
		end,
	}):sync()
	return stdout, ret, stderr
end

local load_once = function(f)
	local resolved = nil
	return function(...)
		if resolved == nil then
			resolved = f()
		end

		return resolved(...)
	end
end

return os
