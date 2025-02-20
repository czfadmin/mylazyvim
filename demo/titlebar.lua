local M = {}

-- 设置默认配置
M.options = {
  separator_style = "thin",
  show_file_path = true,
  show_modified = true,
  show_encoding = true,
  show_filetype = true,
  colors = {
    background = "#282c34",
    foreground = "#abb2bf",
    modified = "#e5c07b",
    separator = "#4b5263",
  },
}

-- 获取当前文件信息
local function get_file_info()
  local file_name = vim.fn.expand("%:t")
  local file_path = vim.fn.expand("%:p:h")
  local modified = vim.bo.modified
  local readonly = vim.bo.readonly
  local filetype = vim.bo.filetype
  local encoding = vim.bo.fileencoding

  return {
    name = file_name ~= "" and file_name or "[No Name]",
    path = file_path,
    modified = modified,
    readonly = readonly,
    filetype = filetype ~= "" and filetype or "no ft",
    encoding = encoding ~= "" and encoding or "utf-8",
  }
end

-- 生成标题栏内容
local function generate_titlebar()
  local info = get_file_info()
  local components = {}

  -- 文件路径
  if M.options.show_file_path then
    table.insert(components, "%#TitlebarPath# " .. info.path .. " ")
  end

  -- 文件名
  table.insert(components, "%#TitlebarFileName#" .. info.name)

  -- 修改标记
  if M.options.show_modified and info.modified then
    table.insert(components, "%#TitlebarModified# [+]")
  end

  -- 右对齐
  table.insert(components, "%=")

  -- 文件类型
  if M.options.show_filetype then
    table.insert(components, "%#TitlebarFileType# " .. info.filetype .. " ")
  end

  -- 编码
  if M.options.show_encoding then
    table.insert(components, "%#TitlebarEncoding# " .. info.encoding .. " ")
  end

  return table.concat(components, "")
end

-- 设置高亮组
local function set_highlights()
  local colors = M.options.colors

  vim.api.nvim_command("hi TitlebarPath guifg=" .. colors.foreground .. " guibg=" .. colors.background)
  vim.api.nvim_command("hi TitlebarFileName guifg=" .. colors.foreground .. " guibg=" .. colors.background)
  vim.api.nvim_command("hi TitlebarModified guifg=" .. colors.modified .. " guibg=" .. colors.background)
  vim.api.nvim_command("hi TitlebarFileType guifg=" .. colors.foreground .. " guibg=" .. colors.background)
  vim.api.nvim_command("hi TitlebarEncoding guifg=" .. colors.foreground .. " guibg=" .. colors.background)
end

-- 设置标题栏
function M.setup(opts)
  -- 合并用户配置
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})

  -- 设置高亮
  set_highlights()

  -- 设置标题栏
  vim.o.titlestring = [[%{luaeval('require("titlebar").get_titlebar()')}]]
  vim.o.title = true

  -- 自动命令组
  local group = vim.api.nvim_create_augroup("Titlebar", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufModifiedSet" }, {
    group = group,
    callback = function()
      vim.o.titlestring = generate_titlebar()
    end,
  })
end

-- 获取标题栏内容
function M.get_titlebar()
  return generate_titlebar()
end

return M
