local api = vim.api

local ftAndCmandLeft = {
	undotree = "UndotreeToggle",
	NvimTree = "NvimTreeToggle",
}
local function leftSidebarAutoClose(ftAcmdLeft, currentSelfLeft)
	local winList = vim.api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		for k, v in pairs(ftAcmdLeft) do
			if
				vim.api.nvim_win_is_valid(winHandle)
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") == k
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") ~= currentSelfLeft
			then
				vim.api.nvim_cmd(api.nvim_parse_cmd(v, {}), {})
			end
		end
	end
end

api.nvim_create_user_command("Ut", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "undotree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
end, { desc = "undotree enhanced" })
api.nvim_create_user_command("NvimTrr", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "NvimTree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("NvimTreeToggle", {}), {})
end, { desc = "NvimTree enhanced" })

-- redirect command output
vim.api.nvim_create_user_command("RecommandTo", function(args)
	local cmd = ""
	for _, v in ipairs(args.fargs) do
		cmd = cmd .. v .. " "
	end
	cmd = cmd:gsub("^%s*(.-)%s*$", "%1")
	local text = vim.api.nvim_exec(cmd, true)
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { trimempty = true, plain = true }))
	vim.api.nvim_set_current_buf(buf)
end, {
	desc = "redirect command output",
	nargs = "*",
	complete = function(_, _, _)
		return {
			"messages",
		}
	end,
})
