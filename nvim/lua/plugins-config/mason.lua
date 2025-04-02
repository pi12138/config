local status, mason = pcall(require, "mason")
if not status then
	DebugNotify("没有找到 mason")
	return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local status, masonLsp = pcall(require, "mason-lspconfig")
if not status then
    DebugNotify("没有找到 mason-lspconfig")
    return
end

masonLsp.setup({
    automatic_installation = true,
    ensure_installed = {
        "gopls",
        "lua_ls",
        "pyright",
    },
})
