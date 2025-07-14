return {
  cmd = { "matlab-lsp" },
  filetypes = { "matlab" },
  single_file_support = true,
  root_markers = { ".projectile", ".git" },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8" },
  },
}
