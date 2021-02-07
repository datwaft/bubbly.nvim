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
  lua require'bubbly.highlight'()
" ======================
" Autocommand definition
" ======================
  lua require'bubbly.factories.autocommands'(vim.g.bubbly_statusline)
" ======================================
" Status line and Buffer line definition
" ======================================
  lua _G.statusline = require'bubbly.plugin'
  lua _G.tabline = require'bubbly.factories.tabline'
  augroup BubblyRender
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline()
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline(1)
    if g:bubbly_tabline == 1
      autocmd TabNew,TabLeave,TabClosed,TabEnter * set tabline=%!v:lua.tabline()
    endif
  augroup end
