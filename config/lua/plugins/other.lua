local function setup(name)
  local ok, plugin = pcall(require, name)
  if ok then
    plugin.setup()
  end
end

setup("ibl")
setup("marks")
setup("neoconf")
setup("mini.align")
setup("nvim-surround")
setup("colorizer")
setup("textcase")
setup("git-worktree")
setup("neogit")
