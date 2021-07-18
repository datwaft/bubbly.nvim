" =================
" PLUGIN DEFINITION
" =================
" Created by datwaft <github.com/datwaft>

" ========================
" Define and fuse defaults
" ========================
  lua require'bubbly.defaults'.fusion()
" ====================
" Highlight definition
" ====================
  lua _G.bubbly_highlight = require'bubbly.highlight'
  augroup BubblyHighlight
    autocmd!
    autocmd VimEnter,ColorScheme * :call v:lua.bubbly_highlight()
  augroup end
" ======================
" Autocommand definition
" ======================
  lua require'bubbly.factories.autocommands'(vim.g.bubbly_statusline)
" ======================================
" Status line and Buffer line definition
" ======================================
  lua _G.bubbly_statusline = require'bubbly.plugin'
  lua _G.bubbly_tabline = require'bubbly.factories.tabline'
  augroup BubblyRender
    autocmd!
    autocmd VimEnter,WinEnter,BufEnter * setlocal statusline=%!v:lua.bubbly_statusline()
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.bubbly_statusline(1)
    if g:bubbly_tabline == 1
      autocmd VimEnter,TabNew,TabLeave,TabClosed,TabEnter * set tabline=%!v:lua.bubbly_tabline()
    endif
  augroup end
