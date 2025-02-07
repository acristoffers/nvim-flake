local nix_config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.rtp:append(nix_config_path)

vim.schedule(function()
  local hostname = "localhost"
  local handle = io.popen("hostname")
  if handle ~= nil then
    hostname = vim.fn.trim(handle:read("*a"))
    handle:close()
  end
  vim.fn.setenv("HOSTNAME", hostname)
end)
