local fn = vim.fn
local fmt = string.format
local api = vim.api
local opt = vim.opt
_AsGlobalCallbacks = _AsGlobalCallbacks or {}
_G.qs = {
    _store = _AsGlobalCallbacks,
}

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

function R(name)
	RELOAD(name)
	return require(name)
end

-- inspect the contents of an object very quickly
-- in your code or from the command-line:
-- @see: https://www.reddit.com/r/neovim/comments/p84iu2/useful_functions_to_explore_lua_objects/
-- USAGE:
-- in lua: P({1, 2, 3})
-- in commandline: :lua P(vim.loop)
---@vararg any
function P(...)
  local objects, v = {}, nil
  for i = 1, select('#', ...) do
    v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

---check if a certain feature/version/commit exists in nvim
---@param feature string
---@return boolean
function qs.has(feature)
  return vim.fn.has(feature) > 0
end

function _G.put_text(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, '\n'), '\n')
  local lnum = vim.api.nvim_win_get_cursor(0)[1] vim.fn.append(lnum, lines)
  return ...
end

local installed
---Check if a plugin is on the system not whether or not it is loaded
---@param plugin_name string
---@return boolean
function qs.plugin_installed(plugin_name)
  if not installed then
    local dirs = fn.expand(fn.stdpath 'data' .. '/site/pack/packer/start/*', true, true)
    local opt_dir = fn.expand(fn.stdpath 'data' .. '/site/pack/packer/opt/*', true, true)
    vim.list_extend(dirs, opt_dir)
    installed = vim.tbl_map(function(path)
      return fn.fnamemodify(path, ':t')
    end, dirs)
  end
  return vim.tbl_contains(installed, plugin_name)
end

local installed2
function qs.font_installed(font_name)
  if not installed2 then
		local dirs = fn.expand('/usr/share/fonts/*/*', true, true)
		local sec_dirs = fn.expand('~/.local/share/fonts/*', true, true)
    vim.list_extend(dirs, sec_dirs)
    installed2 = vim.tbl_map(function(path)
      return fn.fnamemodify(path, ':t')
    end, dirs)
  end
  return vim.tbl_contains(installed2, font_name)
end


---Check if a cmd is executable
---@param e string
---@return boolean
function qs.executable(e)
  return fn.executable(e) > 0
end
-- return empty string if connected to internet
-- FIX: It's still detected have access internet when wifi network connected to out quota wifi
-- try another script to know if devices connected to internet or not
-- find a to support all platform without dependency
function qs.checkconnection(status)
	local script = vim.fn.system({"nc", "-zw1", "1.1.1.1", "443"})
	if (script == nil or script == '') then
		return true
	end
--	if type(script) == nil then
--		print(script)
--	end
--		return vim.api.nvim_err_writeln("No Connection")
end

function qs.togglebg()
	-- `vim.g.colors_name` to get current colorscheme
	local bg = vim.o.background
	-- Just in case bg not set
	if bg == nil then
		print("Background: " .. bg)
		bg = "dark"
		vim.o.background = bg
	elseif bg == "dark" then
		vim.o.background = "light"
		print("Background: " .. bg)
		-- TODO: How to toggle theme on kitty
		-- Check what terminal are using ?
		-- if qs.executable("kitty") then
			-- kitty @ set-colors -a $HOME/.config/kitty/gruvaqs-light.conf
			-- print "Running kitty command"
		-- end
	else
		vim.o.background = "dark"
		print("Background: " .. bg)
		-- if qs.executable("kitty") then
			-- Running kitty command
			-- kitty @ set-colors --reset
			-- print "Running kitty command"
		-- end
	end
end

--Echo a msg to the commandline
---@param msg string | table
---@param hl string
function qs.echomsg(msg, hl)
  hl = hl or 'Title'
  local msg_type = type(msg)
  assert(
    msg_type ~= 'string' or msg_type ~= 'table',
    fmt('message should be a string or list of strings not a %s', msg_type)
  )
  if msg_type == 'string' then
    msg = { { msg, hl } }
  end
  vim.api.nvim_echo(msg, true, {})
end

--- Usage:
--- 1. Call `local stop = utils.profile('my-log')` at the top of the file
--- 2. At the bottom of the file call `stop()`
--- 3. Restart neovim, the newly created log file should open
function qs.profile(filename)
  local base = '/tmp/config/profile/'
  fn.mkdir(base, 'p')
  local success, profile = pcall(require, 'plenary.profile.lua_profiler')
  if not success then
    vim.api.nvim_echo({ 'Plenary is not installed.', 'Title' }, true, {})
  end
  profile.start()
  return function()
    profile.stop()
    local logfile = base .. filename .. '.log'
    profile.report(logfile)
    vim.defer_fn(function()
      vim.cmd('tabedit ' .. logfile)
    end, 1000)
  end
end

-- local keymap = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }

function qs._create(f)
  table.insert(qs._store, f)
  return #qs._store
end

function qs._execute(id, args)
  qs._store[id](args)
end

---check if a mapping already exists
---@param lhs string
---@param mode string
---@return boolean
function qs.has_map(lhs, mode)
  mode = mode or 'n'
  return vim.fn.maparg(lhs, mode) ~= ''
end

-- TODO:
function qs.new_project()
	local new_projname = vim.fn.input("Name of Projects: ", "")
	if new_projname == nil or new_projname == '' then
		return vim.api.nvim_err_writeln('Could not create new project '.. new_projname)
	end
	vim.fn.mkdir(new_projname, "p", "")
end

-- WIP
function qs.rename_file()
	-- local loop = vim.loop
	local old_name = vim.fn.expand("%")
	local new_name = vim.fn.input("Rename to " .. vim.fn.expand("%"))
	if not new_name or #new_name == 0 then return end
	local success = vim.loop.qs.fs_rename(vim.fn.expand("%s"), new_name)
	if not success then
      return vim.api.nvim_err_writeln('Could not rename '.. old_name ' to '..new_name)
    end
	-- rename_loaded_buffers(
	-- vim.cmd(":saveas". new_name)
	-- vim.cmd("redraw!")
end

-- Wrapping Toggle
function qs.togglewrap()
	if true == opt.wrap:get() then
		opt.wrap = false
		print("Wrapping Disabled")
	else
		opt.wrap = true
		print("Wrapping Enabled")
	end
end

-- Open with
function qs.openwith(path)
	  if 0 == vim.fn.executable("opout") then
		  vim.api.nvim_err_writeln("Couldn't find `opout` executables")
		  return
	  end
	  -- trim and get the full path
	  path = string.gsub(path, "%s+", "")
	  path = string.gsub(path, "\"", "")
	  path = path == "" and "%" or path
	  path = vim.fn.expand(path)
	  path = vim.fn.fnamemodify(path, ":p")
	  vim.cmd("!opout " ..  path)
	  print(path)
end

function qs.toggleline()
	vim.cmd(":exe 'set nu!' &nu ? 'rnu!' : ''")
	if true == opt.number:get() then
		if true == opt.relativenumber:get() then
			print('Numline: ON | Relative: ON')
		else
			print('Numline: ON | Relative: OFF')
		end
	else
		if true == opt.relativenumber:get() then
			print('Numline: OFF | Relative: ON')
		else
			print('Numline: OFF | Relative: OFF')
		end
	end
end
function qs.loadconfig()
	local conf = require "mario.config"
	return conf
end

function qs.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, L.ERROR, { title = fmt('Error requiring: %s', module) })
  end
  return ok, result
end

---Source a lua or vimscript file
---@param path string path relative to the nvim directory
---@param prefix boolean?
function qs.source(path, prefix)
  if not prefix then
    vim.cmd(fmt('source %s', path))
  else
    vim.cmd(fmt('source %s/%s', vim.fn.stdpath('config'), path))
  end
end
-- local mapx = require'mapx'.setup{ global = true, whichkey = true}
-- qs.nnoremapx = mapx.nnoremap(...)

function qs.merge(...)
  local res = {}
  for i = 1, select('#', ...) do
    local arg = select(i, ...)
    if type(arg) == 'table' then
      for k, v in pairs(arg) do
        if type(k) == 'number' then
          table.insert(res, v)
        else
          res[k] = v
        end
      end
    else
      table.insert(res, arg)
    end
  end
  return res
end


R 'mario.utils.mapping'
R 'mario.utils.misc'
