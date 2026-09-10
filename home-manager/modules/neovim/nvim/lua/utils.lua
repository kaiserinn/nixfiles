local M = {}

function M.safely(f, msg)
	local ok, res = xpcall(f, function(e)
		return debug.traceback(e .. "\n", 2)
	end)
	if ok then
		return true, res
	end
	vim.notify(msg .. "\n\nError during safe execution:\n" .. res, vim.log.levels.WARN)
	return false, nil
end

---@param specs (string|vim.pack.Spec|(string|vim.pack.Spec)[])[]
---@return (string|vim.pack.Spec)[]
function M.flatten_spec(specs)
	local flatten = {}
	for _, item in ipairs(specs) do
		if vim.islist(item) then
			---@cast item (string|vim.pack.Spec)[]
			vim.list_extend(flatten, item)
		else
			table.insert(flatten, item)
		end
	end
	return flatten
end

function M.run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

return M
