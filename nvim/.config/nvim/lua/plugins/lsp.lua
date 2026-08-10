return {
  "neovim/nvim-lspconfig",
  name = "lspconfig",
  dependencies = {
    { "williamboman/mason.nvim",         name = "mason" },
    { "nvim-treesitter/nvim-treesitter", name = "treesitter", branch = "main" },
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "single"
      }
    })

    vim.lsp.enable("cssls")
    vim.lsp.enable("html")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("pyright")
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "hl" },
          },
        },
      },
    })
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--function-arg-placeholders=false" }
    })

    require("nvim-treesitter").setup({
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })

    vim.diagnostic.config({
      virtual_text = {
        prefix = "",
        format = function(d) return d.message end,
      },
      float = { header = "", prefix = "", border = "single", style = "minimal" },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
    })
    local orig_util = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "single"
      return orig_util(contents, syntax, opts, ...)
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.format, { silent = true })
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { silent = true })
    vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, { silent = true })
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { silent = true })
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
    vim.keymap.set("n", "<leader>f", function()
      local filename = vim.fn.expand("%:t")
      local extension = vim.fn.expand("%:e")
      local modified = vim.bo.modified and "" or ""
      local icon, icon_hl = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
      local fullpath = vim.fn.expand("%:p:h")
      local home = vim.fn.expand("~")
      local path = fullpath:gsub("^" .. vim.pesc(home), "~")
      local message = {

        { modified .. " ",              "DiagnosticWarn" },
        { icon and (icon .. " ") or "", icon_hl or "Normal" },
        { path .. "/",                  "Comment" },
        { filename,                     "Title" },
      }

      local tick = vim.b.file_info_tick or 0
      tick = (tick + 1) % 2
      vim.b.file_info_tick = tick

      local dummy_hl = tick == 0 and "Comment" or "Normal"
      table.insert(message, { " ", dummy_hl })

      vim.api.nvim_echo(message, false, {})
    end, { desc = "Show full file info" })
  end
}
