-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

-- open lazy

map("n", "<leader>l", function()
  require("lazy").show()
end)

map("n", "<leader>sur", ":silent! luafile ~/.config/nvim/init.lua")
