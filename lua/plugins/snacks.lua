-- lazy.nvim
return {
  "folke/snacks.nvim",
  priority = 100,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      --
      sections = {
        -- { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    dim = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = true, style = "compact" },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    scope = { enabled = true },
    words = {
      enabled = true,
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
    ---@class snacks.indent.Config
    indent = {
      enabled = true,
      indent = {
        priority = 200,
        char = "╎",
        only_scope = true, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        }, ---@type string|string[] hl groups for indent guides
      },
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 20, -- ms per step
          total = 500, -- maximum duration
        },
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = true, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        }, ---@type  string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
          -- corner_top = "┌",
          -- corner_bottom = "└",
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
      end,
    },
    --
    -- image = {
    --   enabled = true,
    --   --       force = false, -- try displaying the image, even if the terminal does not support it
    --   -- wo = {
    --   --   wrap = false,
    --   --   number = false,
    --   --   relativenumber = false,
    --   --   cursorcolumn = false,
    --   --   signcolumn = "no",
    --   --   foldcolumn = "0",
    --   --   list = false,
    --   --   spell = false,
    --   --   statuscolumn = "",
    -- },
    scroll = { enabled = false },
    gitbrowse = {
      enabled = true,
    },
    --
    lazygit = {
      enabled = true,
    },
    explorer = {
      enabled = false,
    },
    picker = {
      enabled = false,
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
          enabled = false,
        },
      },
    },
    terminal = {
      enabled = false,
    },
    win = {
      enabled = true,
    },
    styles = {
      {
        border = "rounded",
        zindex = 100,
        ft = "markdown",
        wo = {
          winblend = 0,
          wrap = false,
          conceallevel = 2,
          colorcolumn = "",
        },
        bo = { filetype = "snacks_notif" },
      },
      notification_history = {
        border = "rounded",
        zindex = 100,
        width = 0.6,
        height = 0.6,
        minimal = false,
        title = " Notification History ",
        title_pos = "center",
        ft = "markdown",
        bo = { filetype = "snacks_notif_history", modifiable = false },
        wo = { winhighlight = "Normal:SnacksNotifierHistory" },
        keys = { q = "close" },
        relative = "editor",
      },
    },
  },
  keys = {
    {
      "<leader>e",
      false,
    },
    {
      "<leader>E",
      false,
    },

    {
      "<leader>fe",
      false,
    },
    {
      "<leader>fE",
      false,
    },
    -- Other
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },

    -- {
    --   "<c-_>",
    --   function()
    --     Snacks.terminal("", {
    --       win = {
    --         position = "float",
    --         show = true,
    --       },
    --     })
    --   end,
    --   desc = "Toggle Float terminal",
    -- },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>pS",
      function()
        Snacks.profiler.scratch()
      end,
      desc = "Profiler Scratch Bufer (Snacks)",
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
    {
      "<leader>sz",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>sZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
  enabled = true,
}
