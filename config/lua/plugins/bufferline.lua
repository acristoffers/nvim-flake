local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.minimal,
    numbers = "none",
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    indicator = { style = "none" },
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    color_icons = true,
    show_buffer_close_icons = true,
    show_tab_indicators = false,
    -- show_duplicate_prefix = true | false,
    separator_style = { "", "" },
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true,
      delay = 100,
      reveal = { 'close' }
    }
  },
  highlights = require("catppuccin.groups.integrations.bufferline").get({
    custom = {
      all = {
        fill = { bg = require("catppuccin.palettes").get_palette().mantle },
      },
    },
  }),
})
