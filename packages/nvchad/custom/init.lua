-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

--#region local stuff
local vim = vim
local opt = vim.opt
--#endregion

--#region fold
opt.foldmethod = "marker"
opt.foldmarker = "#region,#endregion"
opt.fillchars = "fold: "

function _G.custom_fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
  line = RemoveValue(line, "--#region ") --#endregion
  line = RemoveValue(line, "#region ") --#endregion
	local line_count = vim.v.foldend - vim.v.foldstart + 1

	return " ⚡" .. line .. ": " .. line_count .. " lines"
end

opt.foldtext = "v:lua.custom_fold_text()"
--#endregion

--#region other
opt.relativenumber = true

function RemoveValue(s,k)
    local p=k..",?"
    local _=s:match(p)
    local a=s:gsub(p,"")
    return a
end
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH
opt.autoread = true
--#endregion
