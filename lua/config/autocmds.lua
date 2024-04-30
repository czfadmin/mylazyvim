-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    -- vim.g.sonokai_style = "atlantis"
    -- vim.g.sonokai_better_performance = 1
  end,
})
