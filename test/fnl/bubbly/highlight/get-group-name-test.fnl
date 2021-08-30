(module bubbly.highlight.get-group-name-test
  {autoload {highlight bubbly.highlight}})

(local {: get-group-name} highlight)

(deftest only-foreground
  (t.= "BubblyWhite"
       (get-group-name "white")))

(deftest foreground-and-background
  (t.= "BubblyWhiteBackground"
       (get-group-name "white" "background")))

(deftest foreground-and-attributes
  (t.= "BubblyWhiteItalicBold"
       (get-group-name "white" [:italic :bold])))

(deftest all
  (t.= "BubblyWhiteBackgroundItalicBold"
       (get-group-name "white" "background" [:italic :bold])))

(deftest all-with-empty-attributes
  (t.= "BubblyWhiteBackground"
       (get-group-name "white" "background" [])))
