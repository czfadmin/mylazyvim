return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    source_selector = {
      winbar = true,
      statusline = true,
      sources = {
        {
          source = "filesystem", -- string
          display_name = " 󰉓 Files ", -- string | nil
        },
        {
          source = "buffers", -- string
          display_name = " 󰈚 Buffers ", -- string | nil
        },
        {
          source = "git_status", -- string
          display_name = " 󰊢 Git ", -- string | nil
        },
      },
      content_layout = "start", -- string
      tabs_layout = "equal", -- string
      truncation_character = "…", -- string
      tabs_min_width = nil, -- int | nil
      tabs_max_width = nil, -- int | nil
      padding = 0, -- int | { left: int, right: int }
      separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
      separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
      show_separator_on_edge = false, -- boolean
      highlight_tab = "NeoTreeTabInactive", -- string
      highlight_tab_active = "NeoTreeTabActive", -- string
      highlight_background = "NeoTreeTabInactive", -- string
      highlight_separator = "NeoTreeTabSeparatorInactive", -- string
      highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
    },
    filesystem = {
      find_by_full_path_words = false,
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      window = {
        mappings = {
          ["<F5>"] = "refresh",
        },
      },
    },
    default_component_configs = {
      indent = {
        with_markers = true,
        indenet_mark = ":",
        last_indent_markers = "└",
        indent_size = 2,
      },
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "-", -- this can only be used in the git_status source
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      ["a"] = {
        "add",
        noawait = true,
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "relative", -- "none", "relative", "absolute"
        },
      },
      ["c"] = {
        "copy",
        noawait = true,
        config = {
          show_path = "relative", -- "none", "relative", "absolute"
        },
      },
    },
    nesting_rules = {
      ["js"] = { "js.map" },
      ["package.json"] = {
        pattern = "^package%.json$", -- <-- Lua pattern
        files = { "package-lock.json", "yarn*" }, -- <-- glob pattern
      },
      ["go"] = {
        pattern = "(.*)%.go$", -- <-- Lua pattern with capture
        files = { "%1_test.go" }, -- <-- glob pattern with capture
      },
      ["js-extended"] = {
        pattern = "(.+)%.js$",
        files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
      },
      ["docker"] = {
        pattern = "^dockerfile$",
        ignore_case = true,
        files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
      },
    },
    event_handers = {
      {
        event = "file_added",
        handler = function(args) end,
        id = "created_file_and_open_it_later",
      },
    },
  },
  keys = {
    {
      "<c-n>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = (vim.uv or vim.loop).cwd(),
        })
      end,
      desc = "Toggle Explorer",
    },
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          source = "filesystem",
          reveal = true,
        })
      end,
      desc = "Focus Explorer",
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
