return {
  {
    "christoomey/vim-tmux-navigator",
    name = "tmux-navigator",
    config = function()
      vim.keymap.set("n", "<A-h>", ":TmuxNavigateLeft<CR>", { silent = true })
      vim.keymap.set("n", "<A-j>", ":TmuxNavigateDown<CR>", { silent = true })
      vim.keymap.set("n", "<A-k>", ":TmuxNavigateUp<CR>", { silent = true })
      vim.keymap.set("n", "<A-l>", ":TmuxNavigateRight<CR>", { silent = true })
    end
  },
  {
    "folke/noice.nvim",
    name = "noice",
    config = function()
      require("noice").setup({
        lsp = {
          signature = {
            enabled = false
          }
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup"
        },
        views = {
          cmdline_popup = {
            border = {
              style = "single",
            },
            position = {
              row = "95%",
              col = "50%"
            }
          }
        },
        messages = {
          enabled = true
        }
      })
    end
  }
}
