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

    local timer = (vim.uv or vim.loop).new_timer()
    local freeUseage

    local memoryUseage
    ins_right({
      function()
        if timer and timer:is_active() ~= true then
          freeUseage = vim.uv.get_available_memory() / vim.uv.get_total_memory()
          memoryUseage = string.format("  %.1f%%%%", 100 * (1 - freeUseage))
          timer:start(2000, 0, function()
            timer:stop()
          end)
        end
        return memoryUseage
      end,
      color = function()
        local fg = ""
        local value = 100 * (freeUseage or 0)
        if value >= 85 then
          fg = colors.green
        elseif value >= 70 then
          fg = colors.blue
        elseif value >= 65 then
          fg = colors.yellow
        elseif value >= 40 then
          fg = colors.orange
        elseif value >= 30 then
          fg = colors.red
        end

        return {
          fg = fg,
        }
      end,
    })

    local cpu_useage
    local cpu_timer = (vim.uv or vim.loop).new_timer()

    -- local readCpuInfo = function()
    --   local file = io.open("/proc/stat", "r") -- 打开 /proc/stat 文件
    --   if not file then
    --     cpu_useage = 0
    --     return 0, 0
    --   else
    --     local line = file:read("*line")
    --     local user, nice, system, idle, iowait, irq, softirq, steal =
    --       line:match("cpu%s+(%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")
    --
    --     -- 将字符串转换为数字
    --     user, nice, system, idle, irq, softirq, iowait, steal =
    --       tonumber(user),
    --       tonumber(nice),
    --       tonumber(system),
    --       tonumber(idle),
    --       tonumber(irq),
    --       tonumber(softirq),
    --       tonumber(iowait),
    --       tonumber(steal)
    --
    --     -- 计算 CPU 使用率
    --     local total = user + nice + system + idle + irq + softirq + iowait + steal
    --     return total, idle
    --   end
    -- end

    local get_cpu_info = function()
      local cpu_info = vim.uv.cpu_info()
      local total = 0
      local idle = 0
      if cpu_info ~= nil then
        for _, item in ipairs(cpu_info) do
          total = total + item.times.user + item.times.nice + item.times.idle + item.times.sys + item.times.irq
          idle = idle + item.times.idle
        end
      end
      return total, idle
    end

    ins_right({
      function()
        if cpu_timer and not cpu_timer:is_active() then
          local total1, idle1 = get_cpu_info()
          cpu_timer:start(
            3000,
            3000,
            vim.schedule_wrap(function()
              local total2, idle2 = get_cpu_info()
              local total = total2 - total1
              local _idle_time = idle2 - idle1
              if total ~= 0 then
                cpu_useage = (total - _idle_time) / total
              end
            end)
          )
        end

        return string.format("CPU: %.2f%%%%", cpu_useage * 100)
      end,
      color = function()
        local fg = ""
        local _cpu_useage = cpu_useage or 0
        if _cpu_useage >= 90 then
          fg = colors.red
        elseif _cpu_useage >= 75 then
          fg = colors.orange
        elseif _cpu_useage >= 55 then
          fg = colors.yellow
        elseif _cpu_useage >= 40 then
          fg = colors.blue
        else
          fg = colors.green
        end

        return {
          fg = fg,
        }
      end,
    })

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
