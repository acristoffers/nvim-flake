local function setup(name, opts)
  opts = opts == nil and {} or opts
  local ok, plugin = pcall(require, name)
  if ok then
    plugin.setup(opts)
  end
end

setup("advanced_git_search.snacks")
setup("colorizer")
setup("git-worktree")
setup("diffview")
setup("gitlab", { server = { binary = vim.g.gitlab_server_bin, } })
setup("marks", { default_mappings = false })
setup("neogit")
setup("nvim-dap-virtual-text")
setup("textcase", { default_keymappings_enabled = true, prefix = "gb" })
setup("treesitter-context")
setup("ts_context_commentstring")
setup("cppman")
