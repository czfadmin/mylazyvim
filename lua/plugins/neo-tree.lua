return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<c-n>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = (vim.uv or vim.loop).cwd(),
        })
      end,
      desc = "Focus on Explorer",
    },
    {
      "<leader>r",
      false,
    },
  },
}
