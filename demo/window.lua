local function create_window_with_title()
  -- 获取当前的窗口尺寸
  local width = vim.o.columns
  local height = vim.o.lines

  -- 计算浮动窗口的位置和大小
  local win_width = math.floor(width * 0.5)
  local win_height = math.floor(height * 0.4)
  local col = math.floor((width - win_width) / 2)
  local row = math.floor((height - win_height) / 2)

  -- 创建浮动窗口
  local buf = vim.api.nvim_create_buf(false, true) -- 创建一个空的缓冲区
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = win_width,
    height = win_height,
    style = "minimal", -- 去掉边框等
  })

  -- 设置标题栏的内容
  local title = "我的标题栏"
  vim.api.nvim_buf_set_lines(buf, 0, 1, false, { title })

  -- 设置标题栏的样式（例如，使用不同的颜色）
  vim.api.nvim_win_set_option(win, "winhighlight", "Normal:TitleBackground,CursorLine:TitleForeground")

  -- 你可以在这里继续添加内容或修改窗口的样式等
end

-- 创建一个带有标题栏的浮动窗口
create_window_with_title()
