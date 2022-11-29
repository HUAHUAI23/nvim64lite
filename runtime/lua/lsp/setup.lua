local status, mason = pcall(require, "mason")
if not status then
	vim.notify("没有找到 mason.nvim")
	return
end
mason.setup({
	ui = {
		border = "rounded",
	},
	install_root_dir = require("commConf").sharePath .. "/abc/mason",
})

local mason_lspconfig
status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	vim.notify("没有找到 mason-lspconfig")
	return
end

mason_lspconfig.setup({
	ensure_installed = {
		"bashls",
		"pyright",
		"sqls",
		"jsonls",
	},
	automatic_installation = true,
})

local lspconfig
status, lspconfig = pcall(require, "lspconfig")
if not status then
	vim.notify("没有找到 lspconfig")
	return
end

local servers = {
	bashls = require("lsp.config.bash"),
	pyright = require("lsp.config.pyright"),
	sqls = require("lsp.config.sqls"),
	jsonls = require("lsp.config.json"),
}
for name, config in pairs(servers) do
	if config ~= nil and type(config) == "table" then
		-- 自定义初始化配置文件必须实现on_setup 方法
		config.on_setup(lspconfig[name])
	else
		-- 使用默认参数
		lspconfig[name].setup({})
	end
end
