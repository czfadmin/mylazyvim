-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

-- open lazy

map("n", "<leader>sur", "<cmd>luafile %<cr>", {
  silent = true,
  desc = "luafile %",
  noremap = true,
})

map({ "n", "v", "s" }, "<C-A>", "<cmd>:normal gg<cr>vG<cr>", {
  desc = "Select all",
})

-- map({ "n", "v", "s" }, "<leader>sut", ":Telescope<cr>", {
--   silent = true,
--   desc = "Telescope",
--   noremap = true,
-- })

-- map({ "n", "v", "s" }, "<leader>suc", ":Cheatsheet<cr>", {
--   silent = true,
--   desc = "Cheatsheet",
--   noremap = true,
-- })
--

map({ "n", "v", "s" }, "<leader>sf", function()
  vim.cmd("wa")
end, {
  silent = true,
  desc = "Save all buffers",
  noremap = true,
  callback = function()
    vim.notify("Save all buffers successfully", vim.log.levels.INFO, {})
  end,
})

-- map("n", "<c-\\>", "<cmd>vs<cr>", {
--   buffer = true,
--   noremap = true,
--   desc = "Split Window Right",
-- })
--
-- map(
--   {
--     "n",
--     "v",
--     "s",
--   },
--   "<leader>sv",
--   "<cmd>sp<cr>",
--   {
--     buffer = true,
--     noremap = true,
--     desc = "Split Window Below",
--   }
-- )
