" ==================
" BUBBLY.NVIM PLUGIN
" ==================
" Created by: datwaft [github.com/datwaft]

lua _G.statusline = require('bubbly.plugin')
augroup BubblyRender
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline()
  autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline(true)
augroup end
