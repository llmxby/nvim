local status_ok, aerial= pcall(require, "aerial")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

aerial.setup({
    filter_kind=false
})
telescope.load_extension('aerial')
