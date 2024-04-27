return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
    { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
  },
  opts = {
    options = {
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(count, level, diag, context)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      separator_style = "thin",
      numbers = function(opts)
        return string.format('%s.%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
      themable = true
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
