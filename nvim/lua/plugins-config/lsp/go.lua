local status, nvimLsp = pcall(require, "lspconfig")
if not status then
    DebugNotify("没有找到 lspconfig" )
    return
end

vim.diagnostic.config({
    signs = false,  -- 禁用标记(禁用在signcolumn 上显示的标记, 目的是避免和 gitsigns 插件抢占位置,需要一个更好的解决方案)
})


-- golang language server
nvimLsp.gopls.setup{
    on_attach = function(cli, bufnr)
        SetLSPKeyMap(bufnr)
    end,
    capabilities = Capabilities,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})