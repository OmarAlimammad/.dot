return {
  "stevearc/oil.nvim",
  name = "oil",
  dependencies = { "nvim-tree/nvim-web-devicons", name = "icons" },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 8,
        border = "single"
      },
      confirmation = {
        border = "single"
      },
    })

    vim.keymap.set("n", "<leader>z", require("oil").open_float)
  end
}
