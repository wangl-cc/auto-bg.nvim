# Auto-BG.nvim

A simple neovim plugin to automatically set the background color
when system theme changes (only works on macOS now).

## Installation

Use your favorite plugin manager, for example, with `lazy.nvim`:

```lua
{
  'wangl-cc/auto-bg.nvim',
  event = 'UIEnter',
  opts = {},
}
```

## Thanks

This plugin is inspired by:

- [bouk/dark-mode-notify](https://github.com/bouk/dark-mode-notify):
    [MIT license](https://github.com/bouk/dark-mode-notify/blob/4d7fe211f81c5b67402fad4bed44995344a260d1/LICENSE),
    the swift code based on this project is used to detect system theme changes.
- [vimpostor/vim-lumen](https://github.com/vimpostor/vim-lumen):
    [GPL-3.0 license](https://github.com/vimpostor/vim-lumen/blob/b183859510bebfc9062caf300e24c707a5fe522f/LICENSE.txt),
    the way to start a job to detect system theme changes inside neovim
    are learned from this project.

## Why not use vim-lumen?

I suffered a big deley during startup when using vim-lumen (about 200ms).
