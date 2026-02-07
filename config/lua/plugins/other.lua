local function setup(name, opts)
  opts = opts == nil and {} or opts
  local ok, plugin = pcall(require, name)
  if ok then
    plugin.setup(opts)
  end
end

setup("colorizer")
setup("git-worktree")
setup("marks", { default_mappings = false })
setup("neogit")
setup("textcase", { default_keymappings_enabled = true, prefix = "gb" })
