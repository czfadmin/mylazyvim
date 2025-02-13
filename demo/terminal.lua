local snacks = require("snacks")
local fzfLua = require("fzf-lua")

local map = vim.keymap.set

local M = {}

local terminals = {}
--
-- map("n", "<leader>pt", function()
--   local terminals = snacks.terminal.list()
--   local terms = {}
--   -- print(vim.inspect(terminals))
--   for index, term in ipairs(terminals) do
--     print(term.id, term.win)
--   end
--   -- print(vim.inspect(terms))
-- end, {
--   desc = "Switch terminals",
-- })
--
--
--

-- snacks.terminal.open()
--
--
--
--
--
--
local opts = {
  win = {
    position = "float",
  },
}

local terminal, created = snacks.terminal.get(nil, {
  win = {
    position = "float",
  },
})

if created and terminal then
  table.insert(terminals, {
    terminal = terminal,
    position = "float",
    id = terminal.id,
  })
end

-- terminal:toggle()

-- for index, terminal in ipairs(terminals) do
--   local bufInfo = vim.api.nvim_buf_get_name(terminal.buf)
--   print(index, bufInfo)
-- end

-- local terms = {}
--
-- for _, term in ipairs(terminals) do
--   local bufName = vim.api.nvim_buf_get_name(term.buf)
--   table.insert(terms, {
--     buf = term.buf,
--     terminal = term,
--     bufName = bufName,
--   })
-- end
--
-- fzfLua.fzf_exec(function(cb)
--   for _, item in ipairs(terms) do
--     cb(item.bufName)
--   end
--   cb()
-- end, {
--   -- fn_transform = function(item)
--   --   return item.index .. item.bufName
--   -- end,
--   prompt = "Terminal > ",
--   actions = {
--     ["enter"] = {
--       fn = function(selected)
--         local _selected = vim.tbl_filter(function(item)
--           return item.bufName == selected[1]
--         end, terms)
--
--         if _selected[1] ~= nil then
--           _selected[1].terminal:toggle()
--         end
--         fzfLua:hide()
--       end,
--       exec_silent = true,
--     },
--   },
-- })

print(vim.inspect(snacks.terminal.list()[1].opts.position))

local floatTerminals = vim.tbl_filter(function(item)
  return item.opts.position == "float"
end, snacks.terminal.list())

-- print(vim.inspect(floatTerminals[1]))

-- local newTerminal = snacks.terminal.open(nil, {
--   start_insert = true,
--   win = {
--     position = "float",
--     border = "rounded",
--     show = true,
--     resize = true,
--     fixbuf = true,
--     minimal = false,
--     style = "float",
--   },
-- })
--
-- newTerminal:toggle()

-- newTerminal:toggle()
-- vim.cmd("setlocal nonumber norelativenumber")

-- Snacks.terminal(nil, {
--   win = {
--     position = "bottom",
--     style = "float",
--   },
-- })

-- local floatTerminal = snacks.terminal(nil, {
--   win = {
--     position = "float",
--     border = "rounded",
--   },
-- })
