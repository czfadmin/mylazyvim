return {
  "localplugins.tabbar",
  dir = "~/.config/nvim/localplugins/tabbar/",
  config = function(_, opts)
    require("tabbar").setup(opts)
  end,
  enabled = true,
}
