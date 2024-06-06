return {
  "nvim-cmp",
  event = "InsertEnter",
  dependencies = {

    {
      "garymjr/nvim-snippets",
      opts = {
        friendly_snippets = true,
        global_snippets = { "all", "global" },
      },
      dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- autopairing of (){}[] etc
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },

    -- cmp sources plugins
    {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    {
      "onsails/lspkind.nvim",
    },
  },
  opts = function(_, opts)
    opts.snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }

    opts.window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:PmenuSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    }

    opts.view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    }

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 80,
          show_labelDetails = true,
          ellipsis_char = "...",
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    " .. (strings[2] or "") .. " "
        return kind
      end,
    }
    table.insert(opts.sources, { name = "luasnip" })
  end,
}
