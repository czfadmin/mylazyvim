-- local timer = vim.uv:new_timer()
--
-- timer:start(
--   0,
--   2000,
--   vim.schedule_wrap(function()
--     vim.uv.spawn("ps", {
--       args = {
--         "-A",
--         "-o",
--         "%cpu",
--       },
--       stdio = {
--         nil,
--         vim.uv.new_pipe(false),
--         vim.uv.new_pipe(false),
--       },
--     }, function(code, signal)
--       if code ~= 0 then
--         print("Error running ps command")
--       else
--         print("CPU info retrieved successfully.")
--       end
--     end)
--   end)
-- )
--
--
--
--
--
-- local _cpuUseage = 0
-- local file = io.open("/proc/stat", "r") -- 打开 /proc/stat 文件
-- if not file then
--   _cpuUseage = 0
-- else
--   local line = file:read("*line")
--   print(vim.inspect(line))
--   local user, nice, system, idle, iowait, irq, softirq, steal =
--     line:match("cpu%s+(%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")
--
--   -- 将字符串转换为数字
--   user, nice, system, idle, irq, softirq, iowait, steal =
--     tonumber(user),
--     tonumber(nice),
--     tonumber(system),
--     tonumber(idle),
--     tonumber(irq),
--     tonumber(softirq),
--     tonumber(iowait),
--     tonumber(steal)
--
--   -- 计算 CPU 使用率
--   local total = user + nice + system + idle + irq + softirq + iowait + steal
--   _cpuUseage = 100 * (user + nice + system) / total -- 计算 CPU 使用率百分比
-- end
--
-- print(string.format("CPU: %.2f%%", _cpuUseage))

local cpu_useage
local cpu_timer = (vim.uv or vim.loop).new_timer()
local get_cpu_info = function()
  local cpu_info = vim.uv.cpu_info()
  local total = 0
  local idle = 0
  if cpu_info ~= nil then
    for _, item in ipairs(cpu_info) do
      -- print(vim.inspect(item))
      total = total + item.times.user + item.times.nice + item.times.idle + item.times.sys + item.times.irq
      idle = idle + item.times.idle
    end
  end
  return total, idle
end

local total1, idle1 = get_cpu_info()
cpu_timer:start(
  0,
  2000,
  vim.schedule_wrap(function()
    local total2, idle2 = get_cpu_info()
    local total = total2 - total1
    local _idle_time = idle2 - idle1
    if total ~= 0 then
      cpu_useage = (total - _idle_time) / total
    end
    print(cpu_useage)
  end)
)
