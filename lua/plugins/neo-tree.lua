return {
  "nvim-neo-tree/neo-tree.nvim",
  priority = 100,
  lazy = true,
  enabled = true,
  opts = function(_, opts)
    local _opts = {
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      reveal = false,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = true, -- used when sorting files and directories in the tree
      sort_function = nil, -- use a custom function for sorting files and directories in the tree
      source_selector = {
        winbar = false,
        statusline = true,
        sources = {
          {
            source = "filesystem", -- string
            display_name = " 󰉓 Files ", -- string | nil
          },
          -- {
          --   source = "buffers", -- string
          --   display_name = " 󰈚 Buffers ", -- string | nil
          -- },
          -- {
          --   source = "git_status", -- string
          --   display_name = " 󰊢 Git ", -- string | nil
          -- },
        },
        content_layout = "start", -- string
        tabs_layout = "equal", -- string
        truncation_character = "…", -- string
        tabs_min_width = nil, -- int | nil
        tabs_max_width = nil, -- int | nil
        padding = {
          left = 0,
          right = 0,
        },
        separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
        separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
        show_separator_on_edge = true, -- boolean
        highlight_tab = "NeoTreeTabInactive", -- string
        highlight_tab_active = "NeoTreeTabActive", -- string
        highlight_background = "NeoTreeTabInactive", -- string
        highlight_separator = "NeoTreeTabSeparatorInactive", -- string
        highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
      },
      filesystem = {
        find_by_full_path_words = true,
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            "node_modules",
            ".git",
          },
          hide_by_pattern = { -- uses glob style patterns
            "*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
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
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        window = {
          mappings = {
            ["<F5>"] = "refresh",
            ["P"] = "toggle_preview",
            -- ["e"] = function()
            --   vim.api.nvim_exec2("Neotree focus filesystem left", {
            --     output = false,
            --   })
            -- end,
            -- ["b"] = function()
            --   vim.api.nvim_exec2("Neotree focus buffers left", { output = false })
            -- end,
            -- ["g"] = function()
            --   vim.api.nvim_exec2("Neotree focus git_status left", {
            --     output = false,
            --   })
            -- end,
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          with_markers = true,
          indent_marker = "|",
          last_indent_markers = "└",
          indent_size = 2,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "󰐕", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "-", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "?",
            ignored = "",
            unstaged = " ",
            staged = "",
            conflict = "",
          },
        },
        diagnostics = {
          symbols = {
            hint = "󰌶",
            info = "",
            warn = "",
            error = "",
          },
          highlights = {
            hint = "DiagnosticSignHint",
            info = "DiagnosticSignInfo",
            warn = "DiagnosticSignWarn",
            error = "DiagnosticSignError",
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
            show_path = "absolute", -- "none", "relative", "absolute"
          },
        },
        ["c"] = {
          "copy",
          noawait = true,
          config = {
            show_path = "absolute", -- "none", "relative", "absolute"
          },
        },
      },
      nesting_rules = {
        ["js"] = { "js.map" },
        ["package.json"] = {
          pattern = "^package%.json$", -- <-- Lua pattern
          files = { "package-lock.json", "yarn*", "pnpm-lock.yaml" }, -- <-- glob pattern
        },
        ["tsconfig.json"] = {
          pattern = "^tsconfig%.json$", -- <-- Lua pattern
          files = { "tsconfig.*.json" }, -- <-- glob pattern
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
          handler = function(args)
            vim.cmd("edit! " .. args.source)
          end,
          id = "created_file_and_open_it_later",
        },
        {
          event = "neo_tree_popup_input_ready",
          handler = function(args)
            vim.cmd("stopinsert")
            vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
          end,
        },
        -- {
        --   event = "neo_tree_buffer_enter",
        --   handler = function()
        --     vim.cmd("highlight! Cursor blend=100")
        --   end,
        -- },
        -- {
        --   event = "neo_tree_buffer_leave",
        --   handler = function()
        --     vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
        --   end,
        -- },
        -- {
        --   event = "after_render",
        --   handler = function(state)
        --     if state.current_position == "left" or state.current_position == "right" then
        --       vim.api.nvim_win_call(state.winid, function()
        --         local str = require("neo-tree.ui.selector").get()
        --         if str then
        --           _G.__cached_neo_tree_selector = str
        --         end
        --       end)
        --     end
        --   end,
        -- },
        -- {
        --   event = "file_opened",
        --   handler = function(file_path)
        --     require("neo-tree.sources.filesystem").reset_search(state)
        --   end,
        -- },
      },
    }

    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    vim.tbl_deeep_extend("force", opts, _opts)

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
  end,
  keys = {
    {
      "<c-n>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = (vim.uv or vim.loop).cwd(),
        })
      end,
      mode = { "t", "n", "v" },
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
