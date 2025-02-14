local timer = (vim.uv or vim.loop).new_timer()
local useage

local count = 0
while count < 300 do
  if timer:is_active() ~= true then
    timer:start(0, 200, function()
      timer:stop()
    end)
    print("Useage")
  end
  count = count + 1
end
