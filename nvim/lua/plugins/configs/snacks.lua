-- Snacks has a lot of sub-plugins so it gets a top-level file
return
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {},
    image = {}
  }
}
