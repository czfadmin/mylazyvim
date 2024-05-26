-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

-- open lazy

map("n", "<leader>l", function()
  require("lazy").show()
end)

-- map({ "n", "i", "s", "v" }, "<leader>sua", "<cmd>:wa<cr>", {
--   silent = true,
--   desc = "Save all",
--   noremap = true,
--   callback = function()
--     vim.notify("Save all sucessfully!")
--   end,
-- })
--
map("n", "<leader>sur", ":luafile %", {
  silent = true,
  desc = "luafile %",
  noremap = true,
})

map({ "n", "v", "s" }, "<leader>sut", "<cmd>Telescope<cr>", {
  silent = true,
  desc = "Telescope",
  noremap = true,
})
