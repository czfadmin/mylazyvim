return {
  "williamboman/mason.nvim",
  lazy = true,
  opts = {
    ensure_installed = { "stylua", "shellcheck", "shfmt", "flake8", "prettier", "biome" },
  },
}
