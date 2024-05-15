return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  config = function(opt)
    require("window-picker").setup(opt)
  end,
}
