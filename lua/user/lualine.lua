local lualine_ok,lualine  = pcall(require, "lualine")
if not lualine_ok then
  return
end

lualine.setup {
  options = {
    -- ... your lualine config
    theme = 'tokyonight'
    -- ... your lualine config
  }
}
