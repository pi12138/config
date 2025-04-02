local status, nvimLsp = pcall(require, "lspconfig")
if not status then
    DebugNotify("没有找到 lspconfig" )
    return
end

vim.diagnostic.config({
    signs = false,  -- 禁用标记(禁用在signcolumn 上显示的标记, 目的是避免和 gitsigns 插件抢占位置,需要一个更好的解决方案)
})

-- lua language server
nvimLsp.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
    DebugNotify("lua_ls init success.")
  end,
  settings = {
    Lua = {
        diagnostics = {
            globals = { 'vim' },
        }
    },
  },
  on_attach = function(cli, bufnr)
    SetLSPKeyMap(bufnr)
  end,
  capabilities = Capabilities,
}