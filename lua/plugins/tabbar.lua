return {
  dir = "~/.config/nvim/localplugins/tabbar",
  config = function(opts)
    require("localplugins.tabbar.init").setup(opts)
  end,
}
