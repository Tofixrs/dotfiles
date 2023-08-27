---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>f"] = {function ()
      vim.diagnostic.open_float(nil, {focus=false})
    end, "Floating diagnostic"}
  },
}

-- more keybinds!

return M
