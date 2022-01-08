vim.cmd [[
 try
 	colorscheme gruvaqs
 catch /^Vim\%((\a\+)\)\=:E185/
   colorscheme default
   set background=dark
 endtry
]]

-- do
-- 	local palette = {
-- 		b_red = '#fb4934',
-- 		l_red = '#cc241d',
-- 		b_green = '#b8bb26',
-- 		l_green = '#98971a',
-- 		b_black = '#928374',
-- 		l_black = '#141414',
-- 		b_white = '#ebdbb2',
-- 		l_white = '#a89984',
-- 		bg = l_black,
-- 		fg = b_white,
-- 	}
-- end

--[[
-- Global Colors:
b/l_red=fb4934,cc241d
b/l_green=b8bb26,98971a
b/l_blue=83a598,458588
b/l_yellow=fabd2f,d79921
b/l_cyan=8ec07c,689d6a
b/l_magenta=d3869b,b16286
b/l_white=ebdbb2,a89984
b/l_black=928374,141414
b/l_purple=
b/l_aqua=
b/l_orange=
fg=$b_white
bg=$l_black
]]
