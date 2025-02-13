-- require'fzf-lua'.fzf_live(
--   function(q)
--     return function(fzf_cb)
--       coroutine.wrap(function()
--         local co = coroutine.running()
--         if tonumber(q) then
--           for i=1,q do
--             -- append our buffer name to the entry
--             -- wrap in vim.schedule to avoid error E5560
--             vim.schedule(function()
--               local bufname = vim.api.nvim_buf_get_name(0)
--               fzf_cb(i..":"..bufname, function() coroutine.resume(co) end)
--             end)
--             -- wait here until coroutine.resume is called
--             coroutine.yield()
--           end
--         end
--         fzf_cb()  -- EOF
--       end)()
--     end
--   end,
--   {
--     prompt = 'Live> ',
--     func_async_callback = false,
--   }
-- )

-- require("fzf-lua").fzf_live("rg --column --color=always -- <query>", {
--   fn_transform = function(x)
--     return require("fzf-lua").make_entry.file(x, { file_icons = true, color_icons = true })
--   end,
-- })
--
-- require("fzf-lua").fzf_live(function(q)
--   return "rg --column --color=always -- " .. vim.fn.shellescape(q or "")
-- end, {
--   fn_transform = function(x)
--     return require("fzf-lua").make_entry.file(x, { file_icons = true, color_icons = true })
--   end,
--   exec_empty_query = true,
-- })
--

-- require("fzf-lua").fzf_live("git rev-list --all | xargs git grep --line-number --column --color=always <query>", {
--   fzf_opts = {
--     ["--delimiter"] = ":",
--     ["--preview-window"] = "nohidden,down,60%,border-top,+{3}+3/3,~3",
--   },
--   preview = "git show {1}:{2} | " .. "batcat --style=default --color=always --file-name={2} --highlight-line={3}",
-- })

-- local snacksTerminal = require("snacks.terminal")
-- local fzfLua = require("fzf-lua")
--
-- local terminals = snacksTerminal.list()

-- print(vim.inspect(terminals))

-- require("fzf-lua").fzf_exec(function(fzf_cb)
--   for _, term in ipairs(terminals) do
--     fzf_cb(term)
--   end
--   fzf_cb() -- EOF
-- end)
--
-- require("fzf-lua").fzf_exec("rg --files", {
--   fn_transform = function(x)
--     return require("fzf-lua").make_entry.file(x, { file_icons = true, color_icons = true })
--   end,
-- })

-- Snacks.win({
--   file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
--   width = 0.6,
--   height = 0.6,
--   wo = {
--     spell = false,
--     wrap = false,
--     signcolumn = "yes",
--     statuscolumn = " ",
--     conceallevel = 3,
--   },
-- })

-- require("fzf-lua").fzf_live(function(q)
--   return function(fzf_cb)
--     coroutine.wrap(function()
--       local co = coroutine.running()
--       if tonumber(q) then
--         for i = 1, q do
--           -- append our buffer name to the entry
--           -- wrap in vim.schedule to avoid error E5560
--           vim.schedule(function()
--             local bufname = vim.api.nvim_buf_get_name(0)
--             fzf_cb(i .. ":" .. bufname, function()
--               coroutine.resume(co)
--             end)
--           end)
--           -- wait here until coroutine.resume is called
--           coroutine.yield()
--         end
--       end
--       fzf_cb() -- EOF
--     end)()
--   end
-- end, {
--   prompt = "Live> ",
--   func_async_callback = false,
-- })
--
--
