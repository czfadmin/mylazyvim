-- Configure LazyVim to load gruvbox
return {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "catppuccin",
    icons = {
      diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      },
    },
  },
  keys = {
    {
      "<leader>l",
      false,
    },
    {
      "<leader>ll",
      mode = { "v", "s", "n" },
      "<cmd>Lazy<cr>",
      desc = "Open Lazy",
    },
    {
      "<leader>le",
      mode = { "v", "s", "n" },
      "<cmd>LazyExtras<cr>",
      desc = "Open Lazy Extras",
    },
    {
      "<leader>lh",
      mode = { "v", "s", "n" },
      "<cmd>LazyHealth<cr>",
      desc = "Open Lazy health",
    },
    {
      "<leader>lc",
      mode = { "v", "s", "n" },
      "<cmd>LazyHealth<cr>",
      desc = "Open Lazy health",
    },
  },
  dependencies = {
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>l"] = { name = "+lazy" },
        },
      },
    },
  },
}
