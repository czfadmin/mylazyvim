return {
  "nvim-telescope/telescope-file-browser.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>tfb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser" },
  },
}
