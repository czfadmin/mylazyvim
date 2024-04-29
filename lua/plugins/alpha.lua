return {
  "goolord/alpha-nvim",
  optional = true,
  enabled = function()
    LazyVim.warn({
      "`dashboard.nvim` is now the default LazyVim starter plugin.",
      "",
      "To keep using `alpha.nvim`, please enable the `lazyvim.plugins.extras.ui.alpha` extra.",
      "Or to hide this message, remove the alpha spec from your config.",
    })
    return false
  end,
}
