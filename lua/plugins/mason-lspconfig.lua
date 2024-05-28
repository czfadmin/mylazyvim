return {
  "williamboman/mason-lspconfig.nvim",
  lazy = true,
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      "prettier",
      "biome",
      "js-debug-adapter",
      "codelldb",
    },
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = false,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},
  },
}
