local api = vim.api

-- TODO: add some description
--
-- local function setUndotreeWinSize()
-- 	local winList = api.nvim_list_wins()
-- 	for _, winHandle in ipairs(winList) do
-- 		if
-- 			api.nvim_win_is_valid(winHandle)
-- 			and api.nvim_buf_get_option(api.nvim_win_get_buf(winHandle), "filetype") == "undotree"
-- 		then
-- 			api.nvim_win_set_width(winHandle, vim.g.undotree_SplitWidth)
-- 		end
-- 	end
-- end
--
-- api.nvim_create_user_command("Ut", function()
-- 	api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
-- 	setUndotreeWinSize()
-- end, { desc = "load undotree" })

-- TODO: add some description
--
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
	leftSidebarAutoClose(ftAndCmandLeft, "undotree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
end, { desc = "undotree enhanced" })
api.nvim_create_user_command("NvimTrr", function()
	leftSidebarAutoClose(ftAndCmandLeft, "NvimTree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("NvimTreeToggle", {}), {})
end, { desc = "NvimTree enhanced" })
