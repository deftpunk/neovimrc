---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = {
        -- this will make LSP diagnostic errors go away when editing my config.
        -- it *may* cause performance problems.
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
}
