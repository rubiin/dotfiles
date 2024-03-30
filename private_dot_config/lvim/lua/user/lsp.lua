
-- formatters setup
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  {
    command = "prettierd",
    filetypes = {
      "css",
      "scss",
      "less",
      "html",
    }
  },
})



-- linters setup

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({
  {
    filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "html",
    "yaml",
    "markdown",
    "markdown.mdx",
    "json", }
  },
})


lvim.lsp.diagnostics.float.max_width = 120
lvim.lsp.diagnostics.float.focusable = true

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
