local toggle_modes = { "n", "t" }
local ft_cmds = {
  python = "python3" .. vim.fn.expand("%"),
}
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
        enabled = true,
        confirm = false,
      },
      close_on_exit = true,
      auto_insert = true,
    },
    silent = true,
  },
  keys = {
    {
      "<C-l>",
      function()
        require("nvterm.terminal").send(ft_cmds[vim.bo.filetype])
      end,
    },
    {
      -- toggle_modes,
      "<A-h>",
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
    },
    {
      -- toggle_modes,
      "<A-v>",
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
    },
    {
      -- toggle_modes,
      "<A-i>",
      function()
        require("nvterm.terminal").toggle("float")
      end,
    },
    {
      "<leader>spt",
      function() end,
      desc = "Pick terminals",
    },
  },
  config = function(_, opts)
    require("nvterm").setup(opts)
  end,
}
