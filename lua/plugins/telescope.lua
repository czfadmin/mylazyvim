return {
  "nvim-telescope/telescope.nvim",
  keys = { -- add a keymap to browse plugin files
    -- stylua: ignore
    {
        "<leader>fp",
        function()
            require("telescope.builtin").find_files({
                cwd = require("lazy.core.config").options.root
            })
        end,
        desc = "Find Plugin File"
    },
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "bottom",
      },
      sorting_strategy = "ascending",
      winblend = 0,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
    extensions_list = { "terms" },
  },
  config = function(_, opts)
    --  dofile(vim.g.base46_cache .. "telescope")
    local telescope = require("telescope")
    telescope.setup(opts)

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
