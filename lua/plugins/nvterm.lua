return {
  "NvChad/nvterm",
  opts = {
    terminals = {
      shell = vim.o.shell,
      list = {},
      type_opts = {
        float = {
          relative = "editor",
          row = 0.3,
          col = 0.25,
          width = 0.5,
          height = 0.4,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = 0.3 },
        vertical = { location = "rightbelow", split_ratio = 0.5 },
      },
    },
    behavior = {
      autoclose_on_quit = {
        enabled = true,
        confirm = false,
      },
      close_on_exit = true,
      auto_insert = true,
    },
    silent = true,
  },
  keys = {
    {
      "<A-h>",
      mode = { "n", "v", "i" },
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
    },
    {
      "<A-v>",
      mode = { "n", "v", "i", "s" },
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
    },
    {
      "<A-i>",
      mode = { "n", "v", "i", "s" },
      function()
        require("nvterm.terminal").toggle("float")
      end,
    },
    {
      "<leader>spt",
      mode = { "n", "v", "s" },
      function()
        local nvterm = require("nvterm.terminal")
        local terminals = nvterm.list_terms()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        -- local get_terminal_buffers = function()
        --   local bufs = vim.api.nvim_list_bufs()
        --   local terminals = {}
        --   for _, buf in ipairs(bufs) do
        --     if vim.api.nvim_buf_is_loaded(buf) then
        --       local buf_name = vim.api.nvim_buf_get_name(buf)
        --       if vim.fn.bufname(buf) == "" then
        --         buf_name = "[No Name]"
        --       end
        --       local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        --       if buftype == "terminal" then
        --         local wins = vim.api.nvim_list_wins()
        --         local win_option
        --         for _, win in ipairs(wins) do
        --           if buf == vim.api.nvim_win_get_buf(win) then
        --             win_option = vim.api.nvim_win_get_config(win)
        --           end
        --         end
        --         table.insert(terminals, { buf = buf, buf_name = buf_name, win_option = win_option })
        --       end
        --     end
        --   end
        --   return terminals
        -- end
        -- local terminals = get_terminal_buffers()

        local _terminals = {}

        for _, term in ipairs(terminals) do
          table.insert(_terminals, {
            buf = term.buf,
            buf_name = vim.api.nvim_buf_get_name(term.buf),
            id = term.id,
            win = term.win,
            type = term.type,
            open = term.buf,
          })
        end

        pickers
          .new({}, {
            prompt_title = " : Switch to Terminal",
            finder = finders.new_table({
              results = _terminals,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.buf_name,
                  ordinal = entry.buf_name,
                }
              end,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr, map)
              map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection ~= nil then
                  nvterm.toggle(selection.value.type)
                  -- local wins = vim.api.nvim_list_wins()
                  -- local bufferInWin
                  -- for _, win in ipairs(wins) do
                  --   local buffer = vim.api.nvim_win_get_buf(win)
                  --   if buffer == selection.value.buf then
                  --     bufferInWin = win
                  --   end
                  -- end
                  -- if bufferInWin == nil then
                  --   bufferInWin = vim.api.nvim_get_current_win()
                  -- end
                  -- vim.api.nvim_win_set_buf(bufferInWin, selection.value.buf)
                end
              end)
              return true
            end,
          })
          :find()
      end,
      desc = " : Switch to Terminal",
    },
  },
  config = function(_, opts)
    require("nvterm").setup(opts)
  end,
  init = function() end,
}
