vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,null-ls-info,help,man,lspinfo,packer,tsplayground,toggleterm nnoremap <silent> <buffer> q :close<CR> 
   " autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', {timeout = 150})
   	autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({timeout = 50})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _py
    autocmd!
    autocmd FileType python nnoremap <silent> <buffer> <leader>mt <cmd>lua _PYTHON_TOGGLE()<CR>
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
		autocmd FileType md,markdown,rmd lua require('mario.keymaps').md_keymaps()
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
