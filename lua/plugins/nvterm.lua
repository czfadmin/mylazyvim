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
      -- toggle_modes,
      "<A-h>",
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
    },
    {
      -- toggle_modes,
      "<A-v>",
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
    },
    {
      -- toggle_modes,
      "<A-i>",
      function()
        require("nvterm.terminal").toggle("float")
      end,
    },
    {
      "<leader>spt",
      function()
        local telescope = require("telescope")
        -- local terminal_picker = telescope.extensions['terminal_picker']
      end,
      desc = "Pick terminals",
    },
  },
  config = function(_, opts)
    require("nvterm").setup(opts)
  end,
  init = function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local get_terminal_buffers = function()
      local bufs = vim.api.nvim_list_bufs()
      local terminals = {}
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if vim.fn.bufname(buf) == "" then
            buf_name = "[No Name]"
          end
          local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
          if buftype == "terminal" then
            table.insert(terminals, { buf, buf_name })
          end
        end
      end
      return terminals
    end
    local terminal_picker = function(opts)
      opts = opts or {}

      local terminals = get_terminal_buffers()

      pickers
        .new(opts, {
          prompt_title = "Switch to Terminal",
          finder = finders.new_table({
            results = terminals,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry[2],
                ordinal = entry[2],
              }
            end,
          }),
          sorter = sorters.get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.api.nvim_set_current_buf(selection.value[1])
            end)
            return true
          end,
        })
        :find()
    end
    require("telescope").register_extension({
      exports = {
        terminal_picker = terminal_picker,
      },
    })
    -- require("telescope").load_extension("terminal_picker")
  end,
}
