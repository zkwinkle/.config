local fcs = vim.opt.fillchars:get()

return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup(
      {
        segments = {
          -- Status column
          { text = { "%s" }, click = "v:lua.ScSa" },
          -- num column
          {
            text = { builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          -- fold column
          --
          -- The plugin provides some built-ins for the behaviour I want:
          -- - Open/Close markers, no fold numbers.
          -- - Open/CLose on clicking the arrows
          --
          -- However, the built-in fold functionality seems to not work with
          -- my setup for whatever reason. So I ended up making my own
          -- function to render open/close markers and after trying for a day
          -- I couldn't get clicking to work.
          {
            text = {
              function(args) -- custom fold symbol function
                local lnum = args.lnum
                if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
                local fold_sym = vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
                return fold_sym
              end,
              " ",
            },
          },
        },
      }
    )
  end,
  event = "VeryLazy",
}
