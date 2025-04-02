local status, nvimLsp = pcall(require, "lspconfig")
if not status then
    DebugNotify("没有找到 lspconfig" )
    return
end

vim.diagnostic.config({
    signs = false,  -- 禁用标记(禁用在signcolumn 上显示的标记, 目的是避免和 gitsigns 插件抢占位置,需要一个更好的解决方案)
})


-- python language server 
nvimLsp.pyright.setup({
    on_attach = function (cli, bufnr)
        SetLSPKeyMap(bufnr)
    end,
    capabilities = Capabilities,
})
