return {
  "saghen/blink.cmp",
  name = "blink",

  dependencies = {
    {"windwp/nvim-autopairs", name = "autopairs" },
  },

  version = "1.*",

  config = function(_, opts)
    require("blink.cmp").setup({
      keymap = { preset = "super-tab" },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = false },
        menu = {
          border = "single",
          scrollbar = false,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    })

    require("nvim-autopairs").setup({ check_ts = true })
  end,
}
