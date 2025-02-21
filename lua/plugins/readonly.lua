return {
  "localplugins.readonly",
  dir = "~/.config/nvim/localplugins/readonly",
  lazy = true,
  config = function(_, opts)
    require("readonly").setup(opts)
  end,
}
