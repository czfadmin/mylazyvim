return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  config = function(_, opts)
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    -- local highlight = { "RainbowRed" }
    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", {
        fg = "#E06C75",
      })
      vim.api.nvim_set_hl(0, "RainbowYellow", {
        fg = "#E5C07B",
      })
      vim.api.nvim_set_hl(0, "RainbowBlue", {
        fg = "#61AFEF",
      })
      vim.api.nvim_set_hl(0, "RainbowOrange", {
        fg = "#D19A66",
      })
      vim.api.nvim_set_hl(0, "RainbowGreen", {
        fg = "#98C379",
      })
      vim.api.nvim_set_hl(0, "RainbowViolet", {
        fg = "#C678DD",
      })
      vim.api.nvim_set_hl(0, "RainbowCyan", {
        fg = "#56B6C2",
      })
    end)
    require("ibl").setup({
      indent = {
        char = "╎",
        tab_char = "╎",
        highlight = highlight,
        smart_indent_cap = true,
        priority = 2,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "Function", "Label" },
        injected_languages = true,
        priority = 20,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    })
  end,
  main = "ibl",
  enabled = true,
}
