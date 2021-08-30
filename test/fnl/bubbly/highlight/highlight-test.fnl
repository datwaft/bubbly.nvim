(module bubbly.highlight.highlight-test
  {autoload {highlight bubbly.highlight}})

(local {: highlight} highlight)

(deftest basic-functionality
  (t.= "highlight BubblyHighlight ctermfg=23 ctermbg=23 cterm=bold,italic guifg=#123456 guibg=#123456 gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "#123456" :bg "#123456"} [:bold :italic])))

(deftest hex-color
  (t.= "highlight BubblyHighlight ctermfg=23 ctermbg=23 cterm=bold,italic guifg=#123456 guibg=#123456 gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "#123456" :bg "#123456"} [:bold :italic])))

(deftest named-color
  (t.= "highlight BubblyHighlight ctermfg=Red ctermbg=Black cterm=bold,italic guifg=Red guibg=Black gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "Red" :bg "Black"} [:bold :italic])))

(deftest highlight-group-color
  (vim.cmd "highlight Test guifg=#123456 guibg=#000000")
  (t.= "highlight BubblyHighlight ctermfg=23 ctermbg=16 cterm=bold,italic guifg=#123456 guibg=#000000 gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "Test foreground" :bg "Test background"} [:bold :italic])))

(deftest highlight-group-color-invalid-key
  (vim.cmd "highlight Test guifg=#123456 guibg=#000000")
  (t.= "highlight BubblyHighlight ctermfg=NONE ctermbg=16 cterm=bold,italic guifg=NONE guibg=#000000 gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "Test forogroud" :bg "Test background"} [:bold :italic])))

(deftest highlight-group-color-invalid-name
  (vim.cmd "highlight Test guifg=#123456 guibg=#000000")
  (t.= "highlight BubblyHighlight ctermfg=NONE ctermbg=16 cterm=bold,italic guifg=NONE guibg=#000000 gui=bold,italic"
       (highlight "BubblyHighlight" {:fg "INVALIDfsdfds foreground" :bg "Test background"} [:bold :italic])))

(deftest empty-attributes
  (t.= "highlight BubblyHighlight ctermfg=23 ctermbg=23 cterm=NONE guifg=#123456 guibg=#123456 gui=NONE"
       (highlight "BubblyHighlight" {:fg "#123456" :bg "#123456"} [])))

(deftest no-attributes
  (t.= "highlight BubblyHighlight ctermfg=23 ctermbg=23 cterm=NONE guifg=#123456 guibg=#123456 gui=NONE"
       (highlight "BubblyHighlight" {:fg "#123456" :bg "#123456"})))
