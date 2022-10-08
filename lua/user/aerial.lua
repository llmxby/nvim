local status_ok, aerial= pcall(require, "aerial")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

aerial.setup({
    filter_kind={
        "Array",
        "Boolean",
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "EnumMember",
        "Event",
        "Field",
        "File",
        "Function",
        "Interface",
        "Key",
        "Method",
        "Module",
        "Namespace",
        "Null",
        "Number",
        "Object",
        "Operator",
        "Package",
        "Property",
        "String",
        "Struct",
        "TypeParameter",
        "Variable",
    }
})
telescope.load_extension('aerial')
