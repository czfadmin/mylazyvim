return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      middle_mouse_command = nil,
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- TODO: 右键展示上下文菜单
      -- stylua: ignore
      -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      right_mouse_command  = "vertical sbuffer %d",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(count, level, diag, context)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = function()
            return vim.fn.getcwd()
          end,
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      color_icons = true,
      get_element_icon = function(element)
        local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      separator_style = "thin",
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      themable = true,
      custom_areas = {
        right = function()
          local result = {}
          local seve = vim.diagnostic.severity
          local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
          local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
          local info = #vim.diagnostic.get(0, { severity = seve.INFO })
          local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

          if error ~= 0 then
            table.insert(result, { text = "  " .. error, fg = "#EC5241" })
          end

          if warning ~= 0 then
            table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
          end

          if hint ~= 0 then
            table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
          end

          if info ~= 0 then
            table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
          end

          table.insert(result, { text = " " })
          return result
        end,
      },
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
