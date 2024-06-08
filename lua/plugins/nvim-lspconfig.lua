local diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
return {
  "neovim/nvim-lspconfig",
  lazy = true,
  dependencies = {
    -- "jose-elias-alvarez/typescript.nvim",
    -- init = function()
    --   require("lazyvim.util").lsp.on_attach(function(_, buffer)
    --     -- stylua: ignore
    --     vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
    --     vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
    --   end)
    -- end,
  },
  opts = {
    inlay_hints = { enabled = true },
    codelens = {
      -- enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = diagnostics.Error,
          [vim.diagnostic.severity.WARN] = diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = diagnostics.Info,
        },
      },
    },

    servers = {
      -- tsserver = {},
      -- vtsls = {},
      dartls = {},
    },
    setup = {
      -- tsserver = function(_, opts)
      --   require("typescript").setup(opts)
      --   return true
      -- end,
      -- vtsls = function(_, opts)
      --   require("vtsls").setup({
      --     servers = opts,
      --     typescript = {
      --       inlayHints = {
      --         parameterNames = { enabled = "literals" },
      --         parameterTypes = { enabled = true },
      --         variableTypes = { enabled = true },
      --         propertyDeclarationTypes = { enabled = true },
      --         functionLikeReturnTypes = { enabled = true },
      --         enumMemberValues = { enabled = true },
      --       },
      --     },
      --   })
      --   return true
      -- end,
    },
  },
}
