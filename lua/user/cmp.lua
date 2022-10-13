local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local lspkind_status_ok, lspkind= pcall(require, "lspkind")
if not lspkind_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	-- formatting = {
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		vim_item.kind = kind_icons[vim_item.kind]
	-- 		vim_item.menu = ({
	-- 			nvim_lsp = "",
	-- 			nvim_lua = "",
	-- 			luasnip = "",
	-- 			buffer = "",
	-- 			path = "",
	-- 			emoji = "",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },
    -- 使用lspkind-nvim显示类型图标
    formatting = {
        format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function (entry, vim_item)
            -- Source 显示提示来源
            vim_item.menu = "["..string.upper(entry.source.name).."]"
            return vim_item
        end
    })},
	sources = {
		{ name = "cmp_tabnine" , priority = 8},
		{ name = "luasnip" , priority = 8},
		{ name = "nvim_lsp" , priority = 8},
		{ name = "buffer" , priority = 7},
		{ name = "nvim_lua" , priority = 5},
		{ name = "path" , priority = 4},
	},
    preselect = cmp.PreselectMode.None,
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
})

local tabnine_status, tabnine = pcall(require, 'cmp_tabnine.config')
if not tabnine_status then
  print 'tabnine could not be found!'
  return
end 

tabnine:setup({
	max_lines = 1000;
	max_num_results = 2;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = {
	};
})

local compare = require('cmp.config.compare')
cmp.setup({
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.locality,
      compare.recently_used,
      compare.score,
      compare.offset,
      compare.order,
      -- compare.exact,
      -- compare.kind,
      -- compare.sort_text,
      -- compare.length,
    },
  },
})
