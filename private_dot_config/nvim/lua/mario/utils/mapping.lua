-- @ mode string|table 
-- @ lhs string
-- @ rhs string
-- @ opt table or string whichkey
local fmt = string.format
local cmd = vim.cmd
local function make_name(config)
	return function(lhs, opts)
    opts = type(opts) == 'string' and { label = opts } or opts and vim.deepcopy(opts) or {}
		if opts.label then
			local ok, wk = pcall(require, 'which-key')
			if ok then
				if type(lhs) == 'table' then
					for _, key in ipairs(lhs) do
						wk.register({ [key] = { name = opts.label },}, { mode = config.mode })
					end
				else
						wk.register({ [lhs] = { name = opts.label }, }, { mode = config.mode })
				end
			end
			opts.label = nil
		end
	end
end


local function make_mapper(config, o)
	if type(config) ~= 'table' then
		config = { mode = config, type = 'map' }
	end
	local parent_opts = vim.deepcopy(o)
	return function(lhs, rhs, opts)
    assert(lhs ~= config.mode, fmt('The lhs should not be the same as mode for %s', lhs))
  	assert(type(rhs) == 'string' or type(rhs) == 'function', '"rhs" should be a function or string')
    -- If the label is all that was passed in, set the opts automagically
    opts = type(opts) == 'string' and { label = opts } or opts and vim.deepcopy(opts) or {}
    local buffer = opts.buffer
    opts.buffer = nil
    if type(rhs) == 'function' then
      local fn_id = qs._create(rhs)
      rhs = string.format('<cmd>lua qs._execute(%s)<CR>', fn_id)
    end

		if opts.label then
			local ok, wk = pcall(require, 'which-key')
			if ok then
				if type(lhs) == 'table' then
					for _, key in ipairs(lhs) do
						wk.register({ [key] = opts.label }, { mode = config.mode })
					end
				else
						wk.register({ [lhs] = opts.label }, { mode = config.mode, buffer = opts.buffer })
				end
			end
			opts.label = nil
		end

    opts = vim.tbl_extend('keep', opts, parent_opts)
    if buffer and type(buffer) == 'number' then
			if type(lhs) == 'table' then
				for _, key in ipairs(lhs) do
					return vim.api.nvim_buf_set_keymap(buffer, config.mode, key, rhs, opts)
				end
			else
				return vim.api.nvim_buf_set_keymap(buffer, config.mode, lhs, rhs, opts)
			end
    end

		if type(lhs) == 'table' then
			for _, key in ipairs(lhs) do
				if vim.fn.has "nvim-0.7" then
					vim.keymap.set(config.mode, key, rhs, opts)
				else
					vim.api.nvim_set_keymap(config.mode, key, rhs, opts)
				end
			end
		else
			if vim.fn.has "nvim-0.7" then
				vim.keymap.set(config.mode, lhs, rhs, opts)
			else
				vim.api.nvim_set_keymap(config.mode, lhs, rhs, opts)
			end
		end
  end
end

local map_opts = { noremap = false }
local noremap_opts = { noremap = true }
qs.nnoremap = make_mapper('n', noremap_opts)
qs.inoremap = make_mapper('i', noremap_opts)
qs.xnoremap = make_mapper('x', noremap_opts)
qs.vnoremap = make_mapper('v', noremap_opts)
qs.tnoremap = make_mapper('t', noremap_opts)
qs.cmap = make_mapper('c', map_opts)
qs.nmap = make_mapper('n', map_opts)
qs.map = make_mapper('', map_opts)
qs.name = make_name('')
-- Whichkey
---Factory function to create multi mode map functions
---e.g. `as.map({"n", "s"}, lhs, rhs, opts)`
---@param target string
---@return fun(modes: string[], lhs: string, rhs: string, opts: table)
local function multimap(target)
  return function(modes, lhs, rhs, opts)
    for _, m in ipairs(modes) do
      qs[m .. target](lhs, rhs, opts)
    end
  end
end

-- nvo
-- qs.map = multimap 'map'
qs.noremap = multimap 'noremap'
