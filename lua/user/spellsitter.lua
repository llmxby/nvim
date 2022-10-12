local ok, spellsitter = pcall(require, "spellsitter")
if not ok then
  vim.notify "Could not load spellsitter"
  return
end

spellsitter.setup {}
