-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

-- open lazy

map("n", "<leader>sur", ":luafile %", {
  silent = true,
  desc = "luafile %",
  noremap = true,
})

map({ "n", "v", "s" }, "<C-A>", "<cmd>:normal gg<cr>vG<cr>", {
  desc = "Select all",
})

map({ "n", "v", "s" }, "<leader>sut", ":Telescope<cr>", {
  silent = true,
  desc = "Telescope",
  noremap = true,
})

map({ "n", "v", "s" }, "<leader>suc", ":Cheatsheet<cr>", {
  silent = true,
  desc = "Cheatsheet",
  noremap = true,
})

map({ "n", "v", "s", "i" }, "<C-S>", "<cmd>:wa<cr>", {
  silent = true,
  desc = "Save all buffers",
  noremap = true,
  buffer = true,
  callback = function()
    vim.notify_once("Save all buffers", vim.log.levels.INFO, {})
  end,
})
