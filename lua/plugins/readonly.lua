return {
  "czfadmin/readonly.nvim",
  event = "BufReadPre",
  -- dir = "~/projects/readonly.nvim",
  enabled = true,
  opts = {
    restricted_directories = {
      "/etc", -- 默认不可编辑的目录
      "/usr", -- 另一个常见的不可编辑目录
      "/var", -- 另一个常见的不可编辑目录
      "/tmp", -- 临时文件目录
      "/opt",
      "lua-language-server/.*",
      ".*/node_modules/.*",
    },
    exclude_directories = {},
  },
  config = function(_, opts)
    require("readonly").setup(opts)
  end,
}
