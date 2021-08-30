(module bubbly.highlight.get-group-name-test
  {autoload {highlight bubbly.highlight}})

(local {: get-group-name} highlight)

(deftest only-foreground
  (t.= "BubblyWhite"
       (get-group-name "white")))

(deftest foreground-and-background
  (t.= "BubblyWhiteBackground"
       (get-group-name "white" "background")))
