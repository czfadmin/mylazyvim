-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
  return vim.api.nvim_create_augroup("user_lazyvim_custom_" .. name, {
    clear = true,
  })
end

-- 当buffer失焦或窗口切换时自动保存未保存的修改
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  group = augroup("auto_save_on_focus_lost"),
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf

    local filetype = vim.api.nvim_get_option_value("filetype", {
      buf = bufnr,
    })
    -- print("🔍 [Debug] BufWritePre triggered!")
    -- print("   Buffer:", bufnr)
    -- print("   Filetype:", filetype)

    local should_skip = false

    -- Skip save for specific filetypes
    local excluded_ft = { "terminal", "neo-tree", "fzf", "noice", "snacks" }
    for _, ft in ipairs(excluded_ft) do
      if string.find(string.lower(filetype), string.lower(ft), nil, true) then
        should_skip = true
        break
      end
    end

    if filetype == nil or should_skip then
      return
    end

    -- 检查buffer是否可编辑、有未保存的修改、不是终端、不是只读且不是neo-tree创建的临时buffer
    if
      vim.api.nvim_get_option_value("modifiable", {
        buf = bufnr,
      })
      and vim.api.nvim_get_option_value("modified", {
        buf = bufnr,
      })
      and not vim.api.nvim_get_option_value("readonly", {
        buf = bufnr,
      })
    then
      -- 避免在neo-tree创建文件时保存空buffer
      local filename = vim.api.nvim_buf_get_name(bufnr)
      if filename ~= "" or (filetype ~= "" and not string.find(filetype, "neo-tree")) then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("write")
        end)
      end
    end
  end,
})
