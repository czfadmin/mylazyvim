return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    spec = {
      { "<leader>d", group = "debug" },
    },
    preset = "modern",
    -- preset = "helix",
  },
  keys = {
    { "<c-\\>", "<cmd>vs<cr>", desc = "Split Window Right", mode = { "n", "i" } },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      mode = { "n" },
      desc = "Toggle Terminal",
    },
    {
      "<c-\\>",
      function()
        local snacks = require("snacks")
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_win_get_buf(current_win)
        local newTerminal = snacks.terminal.open(nil, {
          start_insert = true,
          win = {
            position = "right",
            border = "rounded",
            show = true,
            resize = true,
            fixbuf = true,
            minimal = false,
            style = "split",
            win = current_win,
          },
        })
        vim.cmd("setlocal nonumber norelativenumber")
      end,
      desc = "Split Terminal Right",
      mode = { "t" },
    },

    {
      "<leader>pt",
      function()
        local snacks = require("snacks")
        local fzfLua = require("fzf-lua")
        local terms = {}
        local _terminals = snacks.terminal.list()
        if #_terminals == 0 then
          print("No terminals!")
          return
        end
        for _, term in ipairs(snacks.terminal.list()) do
          table.insert(terms, {
            buf = term.buf,
            terminal = term,
            bufName = vim.api.nvim_buf_get_name(term.buf),
          })
        end

        fzfLua.fzf_exec(function(cb)
          for _, item in ipairs(terms) do
            cb(item.bufName)
          end
        end, {
          prompt = "Terminal >",
          actions = {
            ["enter"] = {
              fn = function(selected)
                if #selected == 0 then
                  return
                end

                local _selected = vim.tbl_filter(function(item)
                  return item.bufName == selected[1]
                end, terms)

                if _selected[1] ~= nil then
                  _selected[1].terminal:toggle()
                end
                fzfLua:hide()
              end,
              exec_silent = true,
            },
          },
        })
      end,
      mode = { "n", "t" },
      desc = "Switch Terminal",
    },

    {
      "<leader>pv",
      function()
        local snacks = require("snacks")
        local floatTerminals = vim.tbl_filter(function(item)
          return item.opts.position == "float"
        end, snacks.terminal.list())

        if #floatTerminals == 0 then
          snacks.terminal.get(nil, {
            win = {
              position = "float",
            },
          })
          return
        end

        if floatTerminals[1]:is_floating() then
          return
        end

        floatTerminals[1]:toggle()
      end,
      desc = "Toggle Float Terminal",
      mode = { "n", "t" },
    },
  },
}
