return {
  "folke/noice.nvim",
  event = "VeryLazy",
  ---@type NoiceConfig
  opts = {
    lsp = {
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          snipppets = true, -- Will open when jumping to placeholders in snippets (Neovim builtin snippets)
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {}, -- merged with defaults from documentation
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- routes = {
    --   {
    --     filter = {
    --       event = "msg_show",
    --       any = {
    --         { find = "%d+L, %d+B" },
    --         { find = "; after #%d+" },
    --         { find = "; before #%d+" },
    --       },
    --     },
    --     view = "mini",
    --   },
    -- },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = "notify", -- default view for messages
      view_error = "notify", -- view for errors
      view_warn = "notify", -- view for warnings
      view_history = "messages", -- view for :messages
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        -- cmdline = { pattern = "^:", icon = "", lang = "vim" },
        -- search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        -- search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        -- filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        -- lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        -- help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰘥 " },
        -- input = {}, -- Used by input()
      },
    },
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = "3%",
              col = "45%",
            },
            size = {
              min_width = 60,
              height = "auto",
              max_height = 15,
            },
          },
          cmdline_popupmenu = {
            position = {
              row = "8%",
              col = "45%",
            },
          },
        },
      }, -- position the cmdline and popupmenu together
      bottom_search = false, -- use a classic bottom cmdline for search
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    silent = true,
  },
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  enabled = true,
}
