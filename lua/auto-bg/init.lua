--[[
A simle plugin to switch between light and dark background automatically.
Copyright (C) 2023 Loong Wang
License: GPLv3
--]]

local tbl = require "auto-bg.table"

local M = {}

---@alias BackgroundEnum `"light"` | `"dark"`

---@class BackgroundSwitcher
---@field pre? fun(): nil Pre switch callback
---@field post? fun(): nil Post switch callback

---@param bg BackgroundEnum Background to switch to
function M.switch(bg)
  if vim.o.background == bg then return end
  local switcher = M.options[bg]
  if not switcher then
    vim.o.background = bg
    return
  end
  if switcher.pre then switcher.pre() end
  vim.o.background = bg
  if switcher.post then switcher.post() end
end

---@class AutoBackgroundOptions
---@field dark? BackgroundSwitcher Switcher options for dark theme
---@field light? BackgroundSwitcher Switcher options for light theme

---@type AutoBackgroundOptions
M.options = {}

M.job = nil

---@param opts AutoBackgroundOptions
function M.setup(opts)
  tbl.merge_one(M.options, opts)

  if M.job then return end

  if vim.loop.os_uname().sysname == "Darwin" then
    local exe = vim.fn.globpath(vim.o.rtp, "build/watcher-universal-macos")
    M.job = vim.fn.jobstart(exe, {
      on_stdout = function(_, data, _)
        ---@type BackgroundEnum
        local bg = data[1]
        M.switch(bg)
      end,
      on_stderr = function(_, _, _)
        vim.notify("Failed to launch watcher", vim.log.levels.ERROR, {
          title = "auto-bg",
        })
      end,
    })
  end
end

return M

-- vim:tw=76:ts=2:sw=2:et
