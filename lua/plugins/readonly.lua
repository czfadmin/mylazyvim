return {
  "localplugins.readonly",
  dir = "~/.config/nvim/localplugins/readonly",
  config = function(_, opts)
    require("localplugins.readonly.init").setup({

      restricted_directories = {
        "/etc", -- 默认不可编辑的目录
        "/opt",
      },
      language_directories = {
        js = { "node_modules", "dist" }, -- Node.js 相关目录
        -- 可以在此处添加其他语言的目录
      },
    })
  end,
}
