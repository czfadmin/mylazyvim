return {
  "nvim-telescope/telescope-project.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>pc",
      mode = { "n" },
      "<CMD>Telescope AddProject<CR>",
      -- ":lua require'telescope'.extensions.project.project{}<CR>",
      desc = "Create a project",
    },
    {
      "<leader>pr",
      mode = { "n" },
      "<CMD>Telescope ProjectRoot<CR>",
      desc = "Telescope project root",
    },

    {
      "<leader>ps",
      mode = { "n" },
      "<CMD>Telescope project<CR>",
      desc = "Telescope project",
    },
  },
}
