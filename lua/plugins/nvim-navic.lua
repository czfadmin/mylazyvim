return {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    LazyVim.lsp.on_attach(function(client, buffer)
      if client.supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = function()
    return {
      separator = "  ",
      highlight = true,
      depth_limit = 3,
      depth_limit_indicator = "..",
      icons = require("lazyvim.config").icons.kinds,
      lazy_update_context = true,
      click = true,
      lsp = {
        auto_attach = true,
      },
    }
  end,
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      init = function()
        LazyVim.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/documentSymbol") then
            require("nvim-navbuddy").attach(client, buffer)
          end
        end)
      end,
      opts = { lsp = { auto_attach = false } },
    },
  },
}
