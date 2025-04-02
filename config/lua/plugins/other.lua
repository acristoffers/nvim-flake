local function setup(name)
  local ok, plugin = pcall(require, name)
  if ok then
    plugin.setup({})
  end
end

setup("colorizer")
setup("git-worktree")
setup("marks")
setup("neogit")

require("textcase").setup {
  default_keymappings_enabled = true,
  prefix = "gb",
}
