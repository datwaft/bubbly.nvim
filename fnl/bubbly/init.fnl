(module bubbly
  {autoload {clj bubbly.lib.cljlib
             fennel aniseed.deps.fennel
             highlight bubbly.highlight}})

(local {: hex->8bit} highlight)

(defn init []
  (print (hex->8bit "008787")))
