return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {
    foldtext = {
      padding = 3,
      lineCount = {
        template = "󰘖 %d",
        hlgroup = "Folded",
      },
      -- Disabled because I can't make the bg color match that of the folded line.
      --
      -- Can't do it because plugin uses gitsigns' highlight groups, but those get used by my
      -- git gutter, whose background is the normal bg color.
      --
      -- See: https://github.com/chrisgrieser/nvim-origami/blob/eba1fb2662fac78dc65f6182f68e82830a3d4ecf/lua/origami/features/foldtext.lua#L71
      gitsignsCount = false,
    },
  },

  -- recommended by plugin: disable vim's auto-folding
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
