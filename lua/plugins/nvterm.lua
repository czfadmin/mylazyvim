return {
  "NvChad/nvterm",
  opts = {
    terminals = {
      shell = vim.o.shell,
      list = {},
      type_opts = {
        float = {
          relative = "editor",
          row = 0.3,
          col = 0.25,
          width = 0.5,
          height = 0.4,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = 0.3 },
        vertical = { location = "rightbelow", split_ratio = 0.5 },
      },
    },
    behavior = {
      autoclose_on_quit = {
        enabled = false,
        confirm = true,
      },
      close_on_exit = true,
      auto_insert = true,
    },
    silent = true,
  },
  keys = {
    {
      "<A-i>",
      function()
        local term = require("nvterm.terminal")
        term.toggle("float")
      end,
    },
    {
      "<A-h>",
      function()
        local term = require("nvterm.terminal")
        term.toggle("horizontal")
      end,
      desc = "Toggle horizontal terminal",
    },
    {
      "<A-v>",
      function()
        local term = require("nvterm.terminal")
        term.toggle("vertical")
      end,
      desc = "Toggle vertical terminal",
    },
  },
  config = function(_, opts)
    require("nvterm").setup(opts)
  end,
}
