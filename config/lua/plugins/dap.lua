local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

dap.adapters.gdb = { type = "executable", command = "gdb", args = { "--quiet", "--interpreter=dap" } }
dap.configurations.c = {
  {
    name = "Attach to process",
    type = "gdb",
    request = "attach",
    pid = require("dap.utils").pick_process,
  },
  {
    name = "Run executable (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      local path = vim.fn.input({
        prompt = "Path to executable: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      })
      return (path and path ~= "") and path or dap.ABORT
    end,
  },
  {
    name = "Run executable with arguments (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      local path = vim.fn.input({
        prompt = "Path to executable: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      })
      return (path and path ~= "") and path or dap.ABORT
    end,
    args = function()
      local args_str = vim.fn.input({ prompt = "Arguments: " })
      return vim.split(args_str, " +")
    end,
  },
}
dap.configurations.cpp = dap.configurations.c

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  return
end

dapui.setup()
dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
