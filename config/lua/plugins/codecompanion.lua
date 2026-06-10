local ok, codecompanion = pcall(require, "codecompanion")
if not ok then
  return
end

local helpers_ok, helpers = pcall(require, "codecompanion.adapters.acp.helpers")

codecompanion.setup({
  adapters = {
    acp = helpers_ok and {
      cursor_cli = function()
        return {
          name = "cursor_cli",
          formatted_name = "Cursor",
          type = "acp",
          roles = { llm = "assistant", user = "user" },
          opts = { vision = true },
          commands = {
            default = { "cursor-agent", "acp" },
          },
          defaults = { mcpServers = {}, timeout = 20000 },
          parameters = {
            protocolVersion = 1,
            clientCapabilities = {
              fs = { readTextFile = true, writeTextFile = true },
            },
            clientInfo = {
              name = "CodeCompanion.nvim",
              version = "1.0.0",
            },
          },
          handlers = {
            setup = function(self) return true end,
            auth = function(self) return true end,
            form_messages = function(self, messages, capabilities)
              return helpers.form_messages(self, messages, capabilities)
            end,
            on_exit = function(self, code) end,
          },
        }
      end,
    } or nil,
  },
  strategies = {
    chat = { adapter = "claude_code" },
    inline = { adapter = "claude_code" },
    agent = { adapter = "claude_code" },
  },
})
