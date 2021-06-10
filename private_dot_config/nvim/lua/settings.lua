--  TODO Change this when this get merge
--  https://github.com/neovim/neovim/pull/13479
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and other programs
vim.o.mouse = "a" --enable mouse support
vim.o.splitbelow = true
vim.o.splitright = true
vim.wo.rnu = true -- {{Hybrid
vim.wo.nu = true --         Line Number}}
vim.t.Co="256"
vim.o.colorcolumn="80"
vim.bo.expandtab = true -- Converts tabs to spaces
-- vim.wo.colorcolumn = "99999"
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
-- vim.o.hidden = O.hidden_files -- Required to keep multiple buffers open multiple buffers
vim.cmd('syntax on')
vim.wo.wrap = false -- Display long lines as just one line
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.guifont = "SFMono\\ Nerd\\ Font\\ Mono:h18"
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
-- vim.cmd('set st=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.o.writebackup=false
vim.o.undofile=true
-- vim.o.autochdir=true
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 300 -- By default timeoutlen is 1000 ms
vim.o.showtabline = 2 -- Always show tabs
vim.cmd('set hidden')
vim.cmd('set backspace=indent,eol,start')
vim.o.scrolloff = 10
-- vim.cmd('set modeline')
-- vim.o.joinspaces = false
