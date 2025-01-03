local ok, util = pcall(require, 'lspconfig.util')
if not ok then
  return {}
end

return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
    root_dir = util.find_git_ancestor,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)"
    }
  },
  single_file_support = true,
}
