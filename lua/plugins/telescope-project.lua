return {
  "nvim-telescope/telescope-project.nvim",
  event = "VeryLazy",
  enabled = true,
  keys = {
    {
      "<leader>pc",
      mode = { "n" },
      function()
        local project_actions = require("telescope._extensions.project.actions")
        project_actions.add_project_cwd({})
      end,
      -- ":lua require'telescope'.extensions.project.project{}<CR>",
      desc = "Projects: add project (cwd)",
    },
    {
      "<leader>pa",
      mode = { "n" },
      function()
        local project_actions = require("telescope._extensions.project.actions")
        project_actions.add_project()
      end,
      desc = "Projects: add project",
    },

    -- {
    --   "<leader>pf",
    --   mode = { "n" },
    --   function()
    --     local project_actions = require("telescope._extensions.project.actions")
    --     project_actions.browse_project_files()
    --   end,
    --   desc = "Projects: browse project files",
    -- },
    -- {
    --   "<leader>pF",
    --   mode = { "n" },
    --   function()
    --     local project_actions = require("telescope._extensions.project.actions")
    --     project_actions.find_project_files()
    --   end,
    --   desc = "Projects: browse project files",
    -- },
    {
      "<leader>ps",
      mode = { "n" },
      function()
        require("telescope").extensions.project.project({})
      end,
      desc = "Projects: project list",
    },
    -- {
    --   "<leader>pd",
    --   mode = { "n" },
    --   function()
    --     local project_actions = require("telescope._extensions.project.actions")
    --     project_actions.delete_project()
    --   end,
    --   desc = "Projects: delete project",
    -- },
    -- {
    --   "<leader>pC",
    --   mode = { "n" },
    --   function()
    --     local project_actions = require("telescope._extensions.project.actions")
    --     project_actions.change_working_directory()
    --   end,
    --   desc = "Projects: change working directory",
    -- },
    -- {
    --   "<leader>pl",
    --   mode = { "n" },
    --   function()
    --     local project_actions = require("telescope._extensions.project.actions")
    --     project_actions.recent_project_files()
    --   end,
    --   desc = "Projects: get recent projects",
    -- },
  },
}
