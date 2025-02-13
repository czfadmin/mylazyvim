-- -- Eviline config for lualine
-- -- Author: shadmansaleh
-- -- Credit: glepnir
-- -- Color table for highlights
-- -- stylua: ignore
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- local macchiato = require("catppuccin.palettes").get_palette()

    local colors = {
      inactive_fg = "#bbc2cf",
      inactive_bg = "#20232a",
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [" "] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        icons_enabled = true,

        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        -- theme = "auto",
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = {
            c = {
              fg = colors.fg,
              bg = colors.bg,
            },
          },
          inactive = {
            c = {
              fg = colors.inactive_fg,
              bg = colors.inactive_bg,
            },
          },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "▊"
      end,
      color = function()
        return {
          fg = mode_color[vim.fn.mode()],
        } -- Sets highlighting of component
      end,
      padding = {
        left = 0,
        right = 1,
      }, -- We don't need space before this
    })

    ins_left({
      -- mode component
      function()
        local mode = {
          n = "Normal",
          v = "Visual",
          o = "Operator-pending",
          i = "Insert",
          c = "Cmd-line",
          s = "Select",
          x = "Visual",
          t = "Terminal-Job",
          ["!"] = "Insert and Cmd-line",
        }
        return "⚡" .. mode[vim.fn.mode()]
      end,
      color = function()
        -- auto change color according to neovims mode
        return {
          fg = mode_color[vim.fn.mode()],
        }
      end,
      padding = {
        right = 0,
      },
    })

    ins_left({
      "branch",
      icon = "",
      color = {
        fg = colors.violet,
        gui = "bold",
      },
    })

    ins_left({
      -- filesize component
      "filesize",
      cond = conditions.buffer_not_empty,
    })

    ins_left({ "location" })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = " ",
        warn = " ",
        info = " ",
      },
      diagnostics_color = {
        color_error = {
          fg = colors.red,
        },
        color_warn = {
          fg = colors.yellow,
        },
        color_info = {
          fg = colors.cyan,
        },
      },
    })

    ins_left({
      function()
        return "  " .. require("dap").status()
      end,
      cond = function()
        return package.loaded["dap"] and require("dap").status() ~= ""
      end,
      -- color = colors.red,
    })

    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      color = {
        fg = colors.magenta,
        gui = "bold",
      },
    })

    -- ins_left({
    --   function()
    --     return require("nvim-navic").get_location()
    --   end,
    --   cond = function()
    --     return package.loaded["nvim-navic"]
    --       and require("nvim-navic").is_available()
    --       and conditions.hide_in_width()
    --       and conditions.buffer_not_empty()
    --   end,
    --   color = {
    --     gui = "bold",
    --     bg = colors.bg,
    --   },
    -- })
    --
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })
    --
    ins_left({
      symbols.get,
      cond = symbols.has,
    })
    -- -- Insert mid section. You can make any number of sections in neovim :)
    -- -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    -- Add components to right sections
    --
    ins_right({
      "progress",
      color = {
        fg = colors.fg,
        gui = "bold",
      },
    })
    ins_right({
      -- Lsp server name .
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return ""
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      color = {
        fg = "#ffffff",
        gui = "bold",
      },
    })

    ins_right({
      "o:encoding", -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = {
        fg = colors.green,
        gui = "bold",
      },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
      color = {
        fg = colors.green,
        gui = "bold",
      },
    })

    ins_right({
      "diff",
      -- Is it me or the symbol for modified us really weird
      symbols = {
        added = " ",
        modified = " ",
        removed = " ",
      },
      diff_color = {
        added = {
          fg = colors.green,
        },
        modified = {
          fg = colors.orange,
        },
        removed = {
          fg = colors.red,
        },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      function()
        return ""
        -- return " " .. (100 * (1 - vim.uv.get_available_memory() / vim.uv.get_total_memory())) .. "%"
      end,
      color = {
        fg = function()
          local value = vim.uv.get_available_memory() * 100 / vim.uv.get_total_memory()
          if value >= 80 then
            return colors.green
          elseif value >= 7 then
            return colors.blue
          elseif value >= 65 then
            return colors.yellow
          elseif value >= 40 then
            return colors.orange
          elseif value >= 30 then
            return colors.red
          end
          return colors.green
        end,
      },
    })

    -- ins_right({
    --   function()
    --     return "" .. vim.uv:getrusage()
    --   end,
    --   color = {
    --     fg = function() end,
    --   },
    -- })
    --
    ins_right({
      function()
        return " " .. os.date("%R")
      end,
      color = {
        fg = colors.red,
      },
    })

    ins_right({
      function()
        return "▊"
      end,
      color = function()
        return {
          fg = mode_color[vim.fn.mode()],
        } -- Sets highlighting of component
      end,
      padding = {
        left = 0,
      },
    })

    return config
  end,
  enable = true,
}
