return {
  root_dir = require('lspconfig.util').root_pattern('.projectile', 'Makefile', '.git'),
  settings = {
    rootPath = ".", -- interpreted relative to the chosen root_dir
    formatterMode = "typstyle",
    fontPaths = { "./fonts" },
  }
}
