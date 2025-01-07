return {
  capabilities = { offsetEncoding = { 'utf-16' } },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--enable-config',
    '--fallback-style=llvm',
    '--function-arg-placeholders',
    '--header-insertion=iwyu',
  },
}
