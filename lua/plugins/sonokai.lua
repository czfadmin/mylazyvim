return {
  "sainnhe/sonokai",
  config = function()
    vim.g.sonkai_enable_italic = true
    vim.g.sonokai_style = "andromeda"
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_dim_inactive_windows = 1
    vim.g.sonokai_diagnostic_text_highlight = 1
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_inlay_hints_background = "dimmed"
    vim.g.sonokai_diagnostic_virtual_text = "colored"
    vim.g.sonokai_current_word = "grey background"
    vim.g.sonokai_inlay_hints_background = "dimmend"
    vim.cmd.colorscheme("sonokai")
  end,
}
