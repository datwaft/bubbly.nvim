" ==================
" BUBBLY.NVIM PLUGIN
" ==================
" Created by: datwaft [github.com/datwaft]


" ========================
" Define and fuse defaults
" ========================
  lua require'bubbly.defaults'.fusion()
" ====================
" Highlight definition
" ====================
  lua require'bubbly.highlight'()
" =====================
" Automation definition
" =====================
  lua _G.get_git_branch = require('bubbly.calculate').git_branch
  augroup BubblyAutomation
    autocmd!
    autocmd BufEnter * let b:git_branch = v:lua.get_git_branch()
  augroup end
" ======================
" Status line definition
" ======================
  lua _G.statusline = require('bubbly.plugin')
  augroup BubblyRender
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline()
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline(1)
  augroup end
