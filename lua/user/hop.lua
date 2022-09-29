local hop_ok, hop = pcall(require, "hop")
if not hop_ok then
  return
end

hop.setup()
