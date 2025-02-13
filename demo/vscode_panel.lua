local M = setmetatable({}, {
  __call = function(t, ...)
    return t.toggle(...)
  end,
})

function create_window(opts) end
function create_panel(opts) end

function M.toggle() end
return M
