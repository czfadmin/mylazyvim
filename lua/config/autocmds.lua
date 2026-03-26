-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
    return vim.api.nvim_create_augroup("user_lazyvim_custom_" .. name, {
        clear = true
    })
end

-- 当buffer失焦或窗口切换时自动保存未保存的修改
vim.api.nvim_create_autocmd({"BufLeave", "WinLeave"}, {
    group = augroup("auto_save_on_focus_lost"),
    pattern = "*",
    callback = function(args)
        local bufnr = args.buf
        -- 检查buffer是否可编辑、有未保存的修改、不是终端且不是只读
        if vim.api.nvim_get_option_value("modifiable", {
            buf = bufnr
        }) and vim.api.nvim_get_option_value("modified", {
            buf = bufnr
        }) and vim.api.nvim_get_option_value("buftype", {
            buf = bufnr
        }) ~= "terminal" and not vim.api.nvim_get_option_value("readonly", {
            buf = bufnr
        }) then
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("write")
            end)
        end
    end
})

