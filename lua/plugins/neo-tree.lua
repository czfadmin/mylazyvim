return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    git = {
      ignore = false,
      enable = true,
    },
  },
  keys = {
    {
      "<c-n>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = (vim.uv or vim.loop).cwd(),
        })
      end,
      desc = "Toggle Explorer",
    },
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          source = "filesystem",
          reveal = true,
        })
      end,
      desc = "Focus Explorer",
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
