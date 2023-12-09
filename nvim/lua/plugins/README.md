# Plugins

All the plugins are declared inside `/configs`.

I've tried to organize them into submodules, here's a short description of each:

- `code`: Stuff that has to do with language support / autocompletion / syntax highlighting.
- `editor`: Stuff that has to do with the experience of editing a buffer (make it prettier / easier to navigate / etc...)
- `ui`: Extra UI elements (status line / filetree / etc...)
- `git`: Anything to do with git.


Anything that doesn't fit these categories and has a short config can go in the `misc.lua` file.`:w

## base16

For the Base16 colorscheme I have the custom nvim-base16 plugin which is [RRethy's nvim-base16 plugin](https://github.com/RRethy/nvim-base16) with additional stuff taken from [mini.nvim](https://github.com/echasnovski/mini.nvim)'s base16 plugin.
