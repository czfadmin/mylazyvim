return {
  "czfadmin/readonly.nvim",
  event = "BufReadPre",
  enabled = true,
  opts = {
    restricted_directories = {
      "/etc", -- 默认不可编辑的目录
      "/usr", -- 另一个常见的不可编辑目录
      "/var", -- 另一个常见的不可编辑目录
      "/tmp", -- 临时文件目录
      "/opt",
      "lua-language-server/**",
    },
    exclude_directories = {},
    language_directories = {
      js = { "node_modules", "dist" }, -- Node.js 相关目录
      python = { "__pycache__", "venv" }, -- Python 相关目录
      ruby = { "vendor", "log" }, -- Ruby 相关目录
      php = { "vendor" }, -- PHP 相关目录
      go = { "bin", "pkg" }, -- Go 相关目录
      java = { "target", "out" }, -- Java 相关目录
      c = { "build", "bin" }, -- C/C++ 相关目录
      rust = { "target" }, -- Rust 相关目录
      elixir = { "_build", "deps" }, -- Elixir 相关目录
      haskell = { ".stack-work" }, -- Haskell 相关目录
      scala = { "target" }, -- Scala 相关目录
    },
  },
  config = function(_, opts)
    require("readonly").setup(opts)
  end,
}
