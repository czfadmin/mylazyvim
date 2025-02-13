print(vim.inspect(vim.uv.metrics_info()))

print(" " .. (vim.uv.get_available_memory() * 100 / vim.uv.get_total_memory()) .. "%")

print(vim.inspect(vim.uv.cpu_info()))

print(vim.inspect(vim.uv.getrusage()))
