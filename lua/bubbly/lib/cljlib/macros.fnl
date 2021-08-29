;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn first [tbl]
  (. tbl 1))

(fn last [tbl]
  (. tbl (length tbl)))

(fn rest [tbl]
  [((or table.unpack _G.unpack) tbl 2)])

(fn string? [x]
  (= (type x) :string))

(fn multisym->sym [s]
  ;; Strip multisym part from symbol and return new symbol and
  ;; indication that sym was transformed.  Non-multisym symbols
  ;; returned as is.
  ;;
  ;; ``` fennel
  ;; (multisym->sym a.b)   ;; => (a true)
  ;; (multisym->sym a.b.c) ;; => (c true)
  ;; (multisym->sym a)     ;; => (a false)
  ;; ```
  (let [parts (multi-sym? s)]
    (if parts
        (values (sym (last parts)) true)
        (values s false))))

(fn contains? [tbl x]
  ;; Checks if `x' is stored in `tbl' in linear time.
  (var res false)
  (each [i v (ipairs tbl)]
    (if (= v x)
        (do (set res i)
            (lua :break))))
  res)

(fn check-two-binding-vec [bindings]
  ;; Test if `bindings' is a `sequence' that holds two forms, first of
  ;; which is a `sym', `table' or `sequence'.
  (and (assert-compile (sequence? bindings)
                       "expected binding table" [])
       (assert-compile (= (length bindings) 2)
                       "expected exactly two forms in binding vector." bindings)
       (assert-compile (or (sym? (first bindings))
                           (sequence? (first bindings))
                           (table? (first bindings)))
                       "expected symbol, sequence or table as binding." bindings)))

(local fennel (require :aniseed.deps.fennel))

(fn attach-meta [value meta]
  (each [k v (pairs meta)]
    (fennel.metadata:set value k v)))


;;;;;;;;;;;;;;;;;;;;;;;;;; Runtime function builders ;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: This code should be shared with `init.fnl'

(fn eq-fn []
  ;; Returns recursive equality function.
  ;;
  ;; This function is able to compare tables of any depth, even if one of
  ;; the tables uses tables as keys.
  `(fn eq# [x# y#]
     (if (= x# y#)
         true
         (and (= (type x#) :table) (= (type y#) :table))
         (do (var [res# count-x# count-y#] [true 0 0])
             (each [k# v# (pairs x#)]
               (set res# (eq# v# ((fn deep-index# [tbl# key#]
                                    (var res# nil)
                                    (each [k# v# (pairs tbl#)]
                                      (when (eq# k# key#)
                                        (set res# v#)
                                        (lua :break)))
                                    res#)
                                  y# k#)))
               (set count-x# (+ count-x# 1))
               (when (not res#)
                 (lua :break)))
             (when res#
               (each [_# _# (pairs y#)]
                 (set count-y# (+ count-y# 1)))
               (set res# (= count-x# count-y#)))
             res#)
         :else
         false)))

(fn seq-fn []
  ;; Returns function that transforms tables and strings into sequences.
  ;;
  ;; Sequential tables `[1 2 3 4]` are shallowly copied.
  ;;
  ;; Associative tables `{:a 1 :b 2}` are transformed into `[[:a 1] [:b 2]]`
  ;; with non deterministic order.
  ;;
  ;; Strings are transformed into a sequence of letters.
  `(fn [col#]
     (let [type# (type col#)
           res# (setmetatable {} {:cljlib/type :seq})
           insert# table.insert]
       (if (= type# :table)
           (do (var assoc?# false)
               (let [assoc-res# (setmetatable {} {:cljlib/type :seq})]
                 (each [k# v# (pairs col#)]
                   (if (and (not assoc?#)
                            (if (= (type col#) :table)
                                (let [m# (or (getmetatable col#) {})
                                      t# (. m# :cljlib/type)]
                                  (if t#
                                      (= t# :table)
                                      (let [(k# _#) ((or m#.cljlib/next next) col#)]
                                        (and (not= k# nil)
                                             (not= k# 1)))))))
                       (set assoc?# true))
                   (insert# res# v#)
                   (insert# assoc-res# [k# v#]))
                 (if assoc?# assoc-res# res#)))
           (= type# :string)
           (if _G.utf8
               (let [char# _G.utf8.char]
                 (each [_# b# (_G.utf8.codes col#)]
                   (insert# res# (char# b#)))
                 res#)
               (do
                 (io.stderr:write "WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
                 (each [b# (col#:gmatch ".")]
                   (insert# res# b#))
                 res#))
           (= type# :nil) nil
           (error "expected table, string or nil" 2)))))

(fn table-type-fn []
  `(fn [tbl#]
     (let [t# (type tbl#)]
       (if (= t# :table)
           (let [meta# (or (getmetatable tbl#) {})
                 table-type# (. meta# :cljlib/type)]
             (if table-type# table-type#
                 (let [(k# _#) ((or meta#.cljlib/next next) tbl#)]
                   (if (and (= (type k#) :number) (= k# 1)) :seq
                       (= k# nil) :empty
                       :table))))
           (= t# :nil) :nil
           (= t# :string) :string
           :else))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Metadata ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn meta [value]
  "Get `value' metadata.  If value has no metadata returns `nil'.

# Example

``` fennel
(meta (with-meta {} {:meta \"data\"}))
;; => {:meta \"data\"}
```

# Note
There are several important gotchas about using metadata.

First, note that this works only when used with Fennel, and only when
`(require fennel)` works.  For compiled Lua library this feature is
turned off.

Second, try to avoid using metadata with anything else than tables and
functions.  When storing function or table as a key into metatable,
its address is used, while when storing string of number, the value is
used.  This, for example, may cause documentation collision, when
you've set some variable holding a number value to have certain
docstring, and later you've defined another variable with the same
value, but different docstring.  While this isn't a major breakage, it
may confuse if someone will explore your code in the REPL with `doc'.

Lastly, note that prior to Fennel 0.7.1 `import-macros' wasn't
respecting `--metadata` switch.  So if you're using Fennel < 0.7.1
this stuff will only work if you use `require-macros' instead of
`import-macros'."
  `(let [(res# fennel#) (pcall require :fennel)]
     (if res# (. fennel#.metadata ,value))))

(fn with-meta [value meta]
  "Attach `meta' to a `value'.

``` fennel
(local foo (with-meta (fn [...] (let [[x y z] [...]] (+ x y z)))
                      {:fnl/arglist [\"x\" \"y\" \"z\" \"...\"]
                       :fnl/docstring \"sum first three values\"}))
;; (doc foo)
;; => (foo x y z ...)
;; =>   sum first three values
```"
  `(let [value# ,value
         (res# fennel#) (pcall require :fennel)]
     (if res#
         (each [k# v# (pairs ,meta)]
           (fennel#.metadata:set value# k# v#)))
     value#))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; fn* ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn keyword? [data]
  (and (= (type data) :string)
       (data:find "^[-%w?\\^_!$%&*+./@:|<=>]+$")))

(fn deep-tostring [data key?]
  (let [tbl []]
    (if (sequence? data)
        (do (each [_ v (ipairs data)]
              (table.insert tbl (deep-tostring v)))
            (.. "[" (table.concat tbl " ") "]"))
        (table? data)
        (do (each [k v (pairs data)]
              (table.insert tbl (.. (deep-tostring k true) " " (deep-tostring v))))
            (.. "{" (table.concat tbl " ") "}"))
        (and key? (keyword? data)) (.. ":" data)
        (string? data)
        (string.format "%q" data)
        (tostring data))))

(fn gen-arglist-doc [args method? multi?]
  (if (list? (. args 1))
      (let [arglist []]
        (each [_ v (ipairs args)]
          (let [arglist-doc (gen-arglist-doc v method? (list? (. args 2)))]
            (when (next arglist-doc)
              (table.insert arglist (table.concat arglist-doc " ")))))
        (when (and (> (length (table.concat arglist " ")) 60)
                   (> (length arglist) 1))
          (each [i s (ipairs arglist)]
            (tset arglist i (.. "\n  " s))))
        arglist)

      (sequence? (. args 1))
      (let [arglist []
            open (if multi? "([" "[")
            close (if multi? "])" "]")
            args (if method?
                     [(sym :self) (table.unpack (. args 1))]
                     (. args 1))
            len (length args)]
        (if (= len 0)
            (table.insert arglist (.. open close))
            (each [i v (ipairs args)]
              (table.insert arglist
                            (match i
                              (1 ? (= len 1)) (.. open (deep-tostring v) close)
                              1   (.. open (deep-tostring v))
                              len (.. (deep-tostring v) close)
                              _   (deep-tostring v)))))
        arglist)))

(fn has-amp? [args]
  ;; Check if arglist has `&` and return its position of `false'.  Performs
  ;; additional checks for `&` and `...` usage in arglist.
  (var res false)
  (each [i s (ipairs args)]
    (if (= (tostring s) "&")
        (if res (assert-compile false "only one `&' can be specified in arglist." args)
            (set res i))
        (= (tostring s) "...")
        (assert-compile false "use of `...' in `fn*' is not permitted. Use `&' if you want a vararg." args)
        (and res (> i (+ res 1)))
        (assert-compile false "only one `more' argument can be supplied after `&' in arglist." args)))
  res)

(fn gen-arity [[args & body] method?]
  ;; Forms three values, representing data needed to create dispatcher:
  ;;
  ;; - the length of arglist;
  ;; - the body of the function we generate;
  ;; - position of `&` in the arglist if any.
  (assert-compile (sequence? args) "fn*: expected parameters table.

* Try adding function parameters as a list of identifiers in brackets." args)
  (when method? (table.insert args 1 (sym :self)))
  (values (length args)
          (list 'let [args ['...]] (list 'do ((or table.unpack _G.unpack) body)))
          (has-amp? args)))

(fn grows-by-one-or-equal? [tbl]
  ;; Checks if table consists of integers that grow by one or equal to
  ;; eachother when sorted.  Used for checking if we supplied all arities
  ;; for dispatching, and there's no need in the error handling.
  ;;
  ;; ``` fennel
  ;; (grows-by-one-or-equal? [1 3 2]) => true, because [1 2 3]
  ;; (grows-by-one-or-equal? [1 4 2]) => true, because 3 is missing
  ;; (grows-by-one-or-equal? [1 3 2 3]) => true, because equal values are allowed.
  ;; ```
  (let [t []]
    (each [_ v (ipairs tbl)] (table.insert t v))
    (table.sort t)
    (var prev nil)
    (each [_ cur (ipairs t)]
      (if prev
          (when (and (not= (+ prev 1) cur)
                     (not= prev cur))
            (lua "return false")))
      (set prev cur))
    prev))

(fn arity-dispatcher [len fixed amp-body name]
  ;; Forms an `if' expression with all fixed arities first, then `&` arity,
  ;; if present, and default error message as last arity.
  ;;
  ;; `len' is a symbol, that represents the length of the current argument
  ;; list, and is computed at runtime.
  ;;
  ;; `fixed' is a table of arities with fixed amount of arguments.  These
  ;; are put in this `if' as: `(= len fixed-len)`, where `fixed-len' is the
  ;; length of current arity arglist, computed with `gen-arity'.
  ;;
  ;; `amp-body' stores size of fixed part of arglist, that is, everything up
  ;; until `&`, and the body itself.  When `amp-body' provided, the `(>= len
  ;; more-len)` is added to the resulting `if' expression.
  ;;
  ;; Lastly the catchall branch is added to `if' expression, which ensures
  ;; that only valid amount of arguments were passed to function, which are
  ;; defined by previous branches.
  (let [bodies '(if)
        lengths []]
    (var max nil)
    (each [fixed-len body (pairs (doto fixed))]
      (when (or (not max) (> fixed-len max))
        (set max fixed-len))
      (table.insert lengths fixed-len)
      (table.insert bodies (list '= len fixed-len))
      (table.insert bodies body))
    (when amp-body
      (let [[more-len body arity] amp-body]
        (assert-compile (not (and max (<= more-len max)))
                        "fn*: arity with `&' must have more arguments than maximum arity without `&'.

* Try adding more arguments before `&'" arity)
        (table.insert lengths (- more-len 1))
        (table.insert bodies (list '>= len (- more-len 1)))
        (table.insert bodies body)))
    (if (not (and (grows-by-one-or-equal? lengths)
                  (contains? lengths 0)
                  amp-body))
        (table.insert bodies (list 'error
                                   (.. "wrong argument amount"
                                       (if name (.. " for "  name) "")) 2)))
    bodies))

(fn single-arity-body [args fname method?]
  ;; Produces arglist and body for single-arity function.
  ;; For more info check `gen-arity' documentation.
  (let [[args & body] args
        (arity body amp) (gen-arity [args ((or table.unpack _G.unpack) body)] method?)]
    `(let [len# (select :# ...)]
       ,(arity-dispatcher
         'len#
         (if amp {} {arity body})
         (if amp [amp body])
         fname))))

(fn multi-arity-body [args fname method?]
  ;; Produces arglist and all body forms for multi-arity function.
  ;; For more info check `gen-arity' documentation.
  (let [bodies {}   ;; bodies of fixed arity
        amp-bodies []] ;; bodies where arglist contains `&'
    (each [_ arity (ipairs args)]
      (let [(n body amp) (gen-arity arity method?)]
        (if amp
            (table.insert amp-bodies [amp body arity])
            (tset bodies n body))))
    (assert-compile (<= (length amp-bodies) 1)
                    "fn* must have only one arity with `&':"
                    (. amp-bodies (length amp-bodies)))
    `(let [len# (select :# ...)]
       ,(arity-dispatcher
         'len#
         bodies
         (if (not= (next amp-bodies) nil)
             (. amp-bodies 1))
         fname))))

(fn method? [s]
  (when (sym? s)
    (let [(res n) (-> s
                      tostring
                      (string.find ":"))]
      (and res (> n 1)))))

(fn demethodize [s]
  (let [s (-> s
              tostring
              (string.gsub ":" "."))]
    (sym s)))

(fn fn* [name doc? ...]
  "Create (anonymous) function of fixed arity.
Accepts optional `name' and `docstring?' as first two arguments,
followed by single or multiple arity bodies defined as lists. Each
list starts with `arglist*' vector, which supports destructuring, and
is followed by `body*' wrapped in implicit `do'.

# Examples
Named function of fixed arity 2:

``` fennel
(fn* f [a b] (+ a b))
```

Function of fixed arities 1 and 2:

``` fennel
(fn* ([x] x)
     ([x y] (+ x y)))
```

Named function of 2 arities, one of which accepts 0 arguments, and the
other one or more arguments:

``` fennel
(fn* f
  ([] nil)
  ([x & xs]
   (print x)
   (f ((or table.unpack _G.unpack) xs))))
```

Note, that this function is recursive, and calls itself with less and
less amount of arguments until there's no arguments, and terminates
when the zero-arity body is called.

Named functions accept additional documentation string before the
argument list:

``` fennel
(fn* cube
     \"raise `x' to power of 3\"
     [x]
     (^ x 3))

(fn* greet
     \"greet a `person', optionally specifying default `greeting'.\"
     ([person] (print (.. \"Hello, \" person \"!\")))
     ([greeting person] (print (.. greeting \", \" person \"!\"))))
```

Argument lists follow the same destruction rules as per `let'.
Variadic arguments with `...` are not supported use `& rest` instead.
Note that only one arity with `&` is supported.

### Namespaces
If function name contains namespace part, defines local variable
without namespace part, then creates function with this name, sets
this function to the namespace, and returns it.

This roughly means, that instead of writing this:

``` fennel
(local ns {})

(fn f [x]                   ;; we have to define `f' without `ns'
  (if (> x 0) (f (- x 1)))) ;; because we're going to use it in `g'

(set ns.f f)

(fn ns.g [x] (f (* x 100))) ;; `g' can be defined as `ns.g' as it is only exported

ns
```

It is possible to write:

``` fennel
(local ns {})

(fn* ns.f [x]
  (if (> x 0) (f (- x 1))))

(fn* ns.g [x] (f (* x 100))) ;; we can use `f' here no problem

ns
```

It is still possible to call `f' and `g' in current scope without `ns'
part, so functions can be reused inside the module, and `ns' will hold
both functions, so it can be exported from the module.

Note that `fn' will not create the `ns' for you, hence this is just a
syntax sugar. Functions deeply nested in namespaces require exising
namespace tables:

``` fennel
(local ns {:strings {}
           :tables {}})

(fn* ns.strings.join
  ([s1 s2] (.. s1 s2))
  ([s1 s2 & strings]
   (join (join s1 s2) ((or table.unpack _G.unpack) strings)))) ;; call `join' resolves to ns.strings.join

(fn* ns.tables.join
  ([t1 t2]
   (let [res []]
     (each [_ v (ipairs t1)] (table.insert res v))
     (each [_ v (ipairs t2)] (table.insert res v))
     res))
  ([t1 t2 & tables]
   (join (join t1 t2) ((or table.unpack _G.unpack) tables)))) ;; call to `join' resolves to ns.tables.join

(assert-eq (ns.strings.join \"a\" \"b\" \"c\") \"abc\")

(assert-eq (join [\"a\"] [\"b\"] [\"c\"] [\"d\" \"e\"])
           [\"a\" \"b\" \"c\" \"d\" \"e\"])
(assert-eq (join \"a\" \"b\" \"c\")
           [])
```

Note that this creates a collision and local `join' overrides `join'
from `ns.strings', so the latter must be fully qualified
`ns.strings.join' when called outside of the function."
  (assert-compile (not (string? name)) "fn* expects symbol, vector, or list as first argument" name)
  (let [docstring (if (string? doc?) doc? nil)
        (name-wo-namespace namespaced?) (multisym->sym name)
        fname (if (sym? name-wo-namespace) (tostring name-wo-namespace))
        method? (method? name)
        name (demethodize name)
        args (if (sym? name-wo-namespace)
                 (if (string? doc?) [...] [doc? ...])
                 [name-wo-namespace doc? ...])
        arglist-doc (gen-arglist-doc args method?)
        [x] args
        body (if (sequence? x) (single-arity-body args fname method?)
                 (list? x) (multi-arity-body args fname method?)
                 (assert-compile false "fn*: expected parameters table.

* Try adding function parameters as a list of identifiers in brackets." x))]
    (if (sym? name-wo-namespace)
        (if namespaced?
            `(local ,name-wo-namespace
                    (do (set ,name (fn ,name-wo-namespace [...] ,docstring ,body)) ;; set function into module table, e.g. (set foo.bar bar)
                        ,(with-meta name `{:fnl/arglist ,arglist-doc
                                           :fnl/docstring ,docstring})))
            `(local ,name ,(with-meta `(fn ,name [...] ,docstring ,body)
                                      `{:fnl/arglist ,arglist-doc
                                        :fnl/docstring ,docstring})))
        (with-meta `(fn [...] ,docstring ,body) `{:fnl/arglist ,arglist-doc
                                                  :fnl/docstring ,docstring}))))

(attach-meta fn* {:fnl/arglist ["name" "docstring?" "([arglist*] body)*"]})


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; let variants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Fennel indeed has more advanced macro `match' which can be used in
;; place of any of the following macros, however it is sometimes more
;; convenient to convey intentions by explicitly saying `when-some'
;; implying that we're interested in non-nil value and only single branch
;; of execution.  The `match' macro on the other hand does not convey
;; such intention

(fn if-let [...]
  "If `binding' is set by `test' to logical true, evaluates `then-branch'
with binding-form bound to the value of test, if not, yields
`else-branch'."
  (let [[bindings then else] (match (select :# ...)
                               2 [...]
                               3 [...]
                               _ (error "wrong argument amount for if-some" 2))]
    (check-two-binding-vec bindings)
    (let [[form test] bindings]
      `(let [tmp# ,test]
         (if tmp#
             (let [,form tmp#]
               ,then)
             ,else)))))

(attach-meta if-let {:fnl/arglist ["[binding test]" "then-branch" "else-branch"]})


(fn when-let [...]
  "If `binding' was bound by `test' to logical true, evaluates `body' in
implicit `do'."
  (let [[bindings & body] (if (> (select :# ...) 0) [...]
                              (error "wrong argument amount for when-let" 2))]
    (check-two-binding-vec bindings)
    (let [[form test] bindings]
      `(let [tmp# ,test]
         (if tmp#
             (let [,form tmp#]
               ,((or table.unpack _G.unpack) body)))))))

(attach-meta when-let {:fnl/arglist ["[binding test]" "&" "body"]})


(fn if-some [...]
  "If `test' is non-`nil', evaluates `then-branch' with `binding'-form bound
to the value of test, if not, yields `else-branch'."
  (let [[bindings then else] (match (select :# ...)
                               2 [...]
                               3 [...]
                               _ (error "wrong argument amount for if-some" 2))]
    (check-two-binding-vec bindings)
    (let [[form test] bindings]
      `(let [tmp# ,test]
         (if (= tmp# nil)
             ,else
             (let [,form tmp#]
               ,then))))))

(attach-meta if-some {:fnl/arglist ["[binding test]" "then-branch" "else-branch"]})


(fn when-some [...]
  "If `test' sets `binding' to non-`nil', evaluates `body' in implicit
`do'."
  (let [[bindings & body] (if (> (select :# ...) 0) [...]
                              (error "wrong argument amount for when-some" 2))]
    (check-two-binding-vec bindings)
    (let [[form test] bindings]
      `(let [tmp# ,test]
         (if (= tmp# nil)
             nil
             (let [,form tmp#]
               ,((or table.unpack _G.unpack) body)))))))

(attach-meta when-some {:fnl/arglist ["[binding test]" "&" "body"]})

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; into ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn table-type [tbl]
  (if (sequence? tbl) :seq
      (table? tbl) :table
      :else))

(fn into [to from]
  "Transform table `from' into another table `to'.  Mutates first table.

Transformation happens in runtime, but type deduction happens in
compile time if possible.  This means, that if literal values passed
to `into' this will have different effects for associative tables and
vectors:

``` fennel
(assert-eq (into [1 2 3] [4 5 6]) [1 2 3 4 5 6])
(assert-eq (into {:a 1 :c 2} {:a 0 :b 1}) {:a 0 :b 1 :c 2})
```

Conversion between different table types is also supported:

``` fennel
(assert-eq (into [] {:a 1}) [[:a 1]])
(assert-eq (into {} [[:a 1] [:b 2]]) {:a 1 :b 2})
```

Same rules apply to runtime detection of table type, except that this
will not work for empty tables:

``` fennel
(local empty-table {})
(assert-eq (into empty-table {:a 1}) [[:a 1]])
``` fennel

If table is empty, `into' defaults to sequential table, because it
allows safe conversion from both sequential and associative tables.

Type for non empty tables hidden in variables can be deduced at
runtime, and this works as expected:

``` fennel
(local t1 [1 2 3])
(local t2 {:a 10 :c 3})
(assert-eq (into t1 {:a 1}) [1 2 3 [:a 1]])
(assert-eq (into t2 {:a 1}) {:a 1 :c 3})
```

`cljlib.fnl' module provides two additional functions `vector' and
`hash-map', that can create empty tables, which can be distinguished
at runtime:

``` fennel
(assert-eq (into (vector) {:a 1}) [[:a 1]])
(assert-eq (into (hash-map) [[:a 1] [:b 2]]) {:a 1 :b 2})
```"
  (assert-compile (and to from) "into: expected two arguments")
  (let [to-type (table-type to)
        from-type (table-type from)]
    (if (and (= to-type :seq) (= from-type :seq))
        `(let [to# (or ,to [])
               insert# table.insert]
           (each [_# v# (ipairs (or ,from []))]
             (insert# to# v#))
           (setmetatable to# {:cljlib/type :seq}))
        (= to-type :seq)
        `(let [to# (or ,to [])
               insert# table.insert]
           (each [_# v# (ipairs (,(seq-fn) (or ,from [])))]
             (insert# to# v#))
           (setmetatable to# {:cljlib/type :seq}))
        (and (= to-type :table) (= from-type :seq))
        `(let [to# (or ,to [])]
           (each [_# [k# v#] (ipairs (or ,from []))]
             (tset to# k# v#))
           (setmetatable to# {:cljlib/type :table}))
        (and (= to-type :table) (= from-type :table))
        `(let [to# (or ,to [])
               from# (or ,from [])]
           (each [k# v# (pairs from#)]
             (tset to# k# v#))
           (setmetatable to# {:cljlib/type :table}))
        (= to-type :table)
        `(let [to# (or ,to [])
               seq# ,(seq-fn)
               from# (or ,from [])]
           (match (,(table-type-fn) from#)
             :seq (each [_# [k# v#] (ipairs (seq# from#))]
                    (tset to# k# v#))
             :table (each [k# v# (pairs from#)]
                      (tset to# k# v#))
             :else (error "expected table as second argument" 2)
             _# (do (each [_# [k# v#] (pairs (or (seq# from#) []))]
                      (tset to# k# v#))
                    to#))
           (setmetatable to# {:cljlib/type :table}))
        ;; runtime branch
        `(let [to# ,to
               from# ,from
               insert# table.insert
               table-type# ,(table-type-fn)
               seq# ,(seq-fn)
               to-type# (table-type# to#)
               to# (or to# []) ;; secure nil
               res# (match to-type#
                      ;; Sequence or empty table
                      (seq1# ? (or (= seq1# :seq) (= seq1# :empty)))
                      (do (each [_# v# (ipairs (seq# (or from# [])))]
                            (insert# to# v#))
                          to#)
                      ;; associative table
                      :table (match (table-type# from#)
                               (seq2# ? (or (= seq2# :seq) (= seq2# :string)))
                               (do (each [_# [k# v#] (ipairs (or from# []))]
                                     (tset to# k# v#))
                                   to#)
                               :table (do (each [k# v# (pairs (or from# []))]
                                            (tset to# k# v#))
                                          to#)
                               :empty to#
                               :else (error "expected table as second argument" 2)
                               _# (do (each [_# [k# v#] (pairs (or (seq# from#) []))]
                                        (tset to# k# v#))
                                      to#))
                      ;; sometimes it is handy to pass nil too
                      :nil (match (table-type# from#)
                             :nil nil
                             :empty to#
                             :seq (do (each [k# v# (pairs (or from# []))]
                                        (tset to# k# v#))
                                      to#)
                             :table (do (each [k# v# (pairs (or from# []))]
                                          (tset to# k# v#))
                                        to#)
                             :else (error "expected table as second argument" 2))
                      :else (error "expected table as second argument" 2)
                      _# (let [m# (or (getmetatable to#) {})]
                           (match m#.cljlib/into
                             f# (f# to# from#)
                             nil (error "expected table as SECOND argument" 2))))]
           (if res#
               (let [m# (or (getmetatable res#) {})]
                 (set m#.cljlib/type (match to-type#
                                       :seq :seq
                                       :empty :seq
                                       :table :table
                                       t# t#))
                 (setmetatable res# m#)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; empty ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn empty [x]
  "Return empty table of the same kind as input table `x', with
additional metadata indicating its type.

# Example
Creating a generic `map' function, that will work on any table type,
and return result of the same type:

``` fennel
(fn map [f tbl]
  (let [res []]
    (each [_ v (ipairs (into [] tbl))]
      (table.insert res (f v)))
    (into (empty tbl) res)))

(assert-eq (map (fn [[k v]] [(string.upper k) v]) {:a 1 :b 2 :c 3})
           {:A 1 :B 2 :C 3})
(assert-eq (map #(* $ $) [1 2 3 4])
           [1 4 9 16])
```
See `into' for more info on how conversion is done."
  (match (table-type x)
    :seq `(setmetatable {} {:cljlib/type :seq})
    :table `(setmetatable {} {:cljlib/type :table})
    _ `(let [x# ,x
             m# (getmetatable x#)]
         (match (and m# m#.cljlib/empty)
           f# (f# x#)
           _# (match (,(table-type-fn) x#)
                :string (setmetatable {} {:cljlib/type :seq})
                :nil nil
                :else (error (.. "can't create sequence from " (type x#)))
                t# (setmetatable {} {:cljlib/type t#}))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; multimethods ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn seq->table [seq]
  (let [tbl {}]
    (for [i 1 (length seq) 2]
      (tset tbl (. seq i) (. seq (+ i 1))))
    tbl))

(fn defmulti [...]
  (let [[name & options] (if (> (select :# ...) 0) [...]
                             (error "wrong argument amount for defmulti"))
        docstring (if (string? (first options)) (first options))
        options (if docstring (rest options) options)
        dispatch-fn (first options)
        options (rest options)]
    (assert (= (% (length options) 2) 0) "wrong argument amount for defmulti")
    (let [options (seq->table options)]
      (if (in-scope? name)
          `nil
          '(local ,name
                  (setmetatable
                   ,(with-meta {} {:fnl/docstring docstring})
                   {:__index
                    (fn [tbl# key#]
                      (let [eq# ,(eq-fn)]
                        (var res# nil)
                        (each [k# v# (pairs tbl#)]
                          (when (eq# k# key#)
                            (set res# v#)
                            (lua :break)))
                        res#))
                    :__call
                    (fn [t# ...]
                      ,docstring
                      (let [dispatch-value# (,dispatch-fn ...)
                            view# #((. (require :aniseed.deps.fennel) :view) $ {:one-line true})]
                        ((or (. t# dispatch-value#)
                             (. t# (or (. ,options :default) :default))
                             (error (.. "No method in multimethod '"
                                        ,(tostring name)
                                        "' for dispatch value: "
                                        (view# dispatch-value#))
                                    2)) ...)))
                    :__name (.. "multifn " ,(tostring name))
                    :__fennelview tostring
                    :cljlib/type :multifn}))))))

(attach-meta defmulti {:fnl/arglist [:name :docstring? :dispatch-fn :options*]
                       :fnl/docstring "Create multifunction `name' with runtime dispatching based on results
from `dispatch-fn'.  Returns a proxy table with `__call` metamethod,
that calls `dispatch-fn' on its arguments.  Amount of arguments
passed, should be the same as accepted by `dispatch-fn'.  Looks for
multimethod based on result from `dispatch-fn'.

Accepts optional `docstring?', and `options*' arguments, where
`options*' is a sequence of key value pairs representing additional
attributes.  Supported options:

`:default` - the default dispatch value, defaults to `:default`.

By default, multifunction has no multimethods, see
`defmethod' on how to add one."})


(fn defmethod [multifn dispatch-val ...]
  (when (= (select :# ...) 0) (error "wrong argument amount for defmethod"))
  `(doto ,multifn (tset ,dispatch-val (do (fn* f# ,...) f#))))

(attach-meta defmethod {:fnl/arglist [:multi-fn :dispatch-value :fnspec]
                        :fnl/docstring "Attach new method to multi-function dispatch value. accepts the
`multi-fn' as its first argument, the `dispatch-value' as second, and
`fnspec' - a function tail starting from argument list, followed by
function body as in `fn*'.

# Examples
Here are some examples how multimethods can be used.

## Factorial example
Key idea here is that multimethods can call itself with different
values, and will dispatch correctly.  Here, `fac' recursively calls
itself with less and less number until it reaches `0` and dispatches
to another multimethod:

``` fennel
(defmulti fac (fn [x] x))

(defmethod fac 0 [_] 1)
(defmethod fac :default [x] (* x (fac (- x 1))))

(assert-eq (fac 4) 24)
```

`:default` is a special method which gets called when no other methods
were found for given dispatch value.

## Multi-arity dispatching
Multi-arity function tails are also supported:

``` fennel
(defmulti foo (fn* ([x] [x]) ([x y] [x y])))

(defmethod foo [10] [_] (print \"I've knew I'll get 10\"))
(defmethod foo [10 20] [_ _] (print \"I've knew I'll get both 10 and 20\"))
(defmethod foo :default ([x] (print (.. \"Umm, got\" x)))
                        ([x y] (print (.. \"Umm, got both \" x \" and \" y))))
```

Calling `(foo 10)` will print `\"I've knew I'll get 10\"`, and calling
`(foo 10 20)` will print `\"I've knew I'll get both 10 and 20\"`.
However, calling `foo' with any other numbers will default either to
`\"Umm, got x\"` message, when called with single value, and `\"Umm, got
both x and y\"` when calling with two values.

## Dispatching on object's type
We can dispatch based on types the same way we dispatch on values.
For example, here's a naive conversion from Fennel's notation for
tables to Lua's one:

``` fennel
(defmulti to-lua-str (fn [x] (type x)))

(defmethod to-lua-str :number [x] (tostring x))
(defmethod to-lua-str :table [x]
  (let [res []]
    (each [k v (pairs x)]
      (table.insert res (.. \"[\" (to-lua-str k) \"] = \" (to-lua-str v))))
    (.. \"{\" (table.concat res \", \") \"}\")))
(defmethod to-lua-str :string [x] (.. \"\\\"\" x \"\\\"\"))
(defmethod to-lua-str :default [x] (tostring x))

(assert-eq (to-lua-str {:a {:b 10}}) \"{[\\\"a\\\"] = {[\\\"b\\\"] = 10}}\")

(assert-eq (to-lua-str [:a :b :c [:d {:e :f}]])
           \"{[1] = \\\"a\\\", [2] = \\\"b\\\", [3] = \\\"c\\\", [4] = {[1] = \\\"d\\\", [2] = {[\\\"e\\\"] = \\\"f\\\"}}}\")
```

And if we call it on some table, we'll get a valid Lua table, which we
can then reformat as we want and use in Lua.

All of this can be done with functions, and single entry point
function, that uses if statement and branches on the type, however one
of the additional features of multimethods, is that separate libraries
can extend such multimethod by adding additional claues to it without
needing to patch the source of the function.  For example later on
support for userdata or coroutines can be added to `to-lua-str'
function as a separate multimethods for respective types."})


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; def and defonce ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn def [...]
  "Wrapper around `local' which can declare variables inside namespace,
and as local `name' at the same time similarly to
`fn*'. Accepts optional `attr-map?' which can contain a
docstring, and whether variable should be mutable or not.  Sets
variable to the result of `expr'.

``` fennel
(def ns {})
(def a 10) ;; binds `a' to `10`

(assert-eq a 10)

(def ns.b 20) ;; binds `ns.b' and `b' to `20`

(assert-eq b 20)
(assert-eq ns.b 20)
```

`a' is a `local', and both `ns.b' and `b' refer to the same value.

Additionally metadata can be attached to values, by providing
attribute map or keyword as first parameter.  Only one keyword is
supported, which is `:mutable`, which allows mutating variable with
`set' later on:

``` fennel
;; Bad, will override existing documentation for 299792458 (if any)
(def {:doc \"speed of light in m/s\"} c 299792458)

(def :mutable address \"Lua St.\") ;; same as (def {:mutable true} address \"Lua St.\")
(set address \"Lisp St.\") ;; can mutate `address'
```

However, attaching documentation metadata to anything other than
tables and functions considered bad practice, due to how Lua
works. More info can be found in `with-meta'
description."
  (let [[attr-map name expr] (match (select :# ...)
                               2 [{} ...]
                               3 [...]
                               _ (error "wrong argument amount for def" 2))
        attr-map (if (table? attr-map) attr-map
                     (string? attr-map) {attr-map true}
                     (error "def: expected keyword or literal table as first argument" 2))
        (s multi) (multisym->sym name)
        docstring (or (. attr-map :doc)
                      (. attr-map :fnl/docstring))
        f (if (. attr-map :mutable) 'var 'local)]
    (if multi
        `(,f ,s (do (,f ,s ,expr)
                    (set ,name ,s)
                    ,(with-meta s {:fnl/docstring docstring})))
        `(,f ,name ,(with-meta expr {:fnl/docstring docstring})))))

(attach-meta def {:fnl/arglist [:attr-map? :name :expr]})

(fn defonce [...]
  "Works the same as `def', but ensures that later `defonce'
calls will not override existing bindings. Accepts same `attr-map?' as
`def', and sets `name' to the result of `expr':

``` fennel
(defonce a 10)
(defonce a 20)
(assert-eq a 10)
```"
  (let [[attr-map name expr] (match (select :# ...)
                               2 [{} ...]
                               3 [...]
                               _ (error "wrong argument amount for def" 2))]
    (if (in-scope? name)
        nil
        (def attr-map name expr))))

(attach-meta defonce {:fnl/arglist [:attr-map? :name :expr]})


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; try ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn catch? [[fun]]
  "Test if expression is a catch clause."
  (= (tostring fun) :catch))

(fn finally? [[fun]]
  "Test if expression is a finally clause."
  (= (tostring fun) :finally))

(fn add-finally [finally form]
  "Stores `form' as body of `finally', which will be injected into
`match' branches at places appropriate for it to run.

Checks if there already was `finally' clause met, which can be only
one."
  (assert-compile (= (length finally) 0)
                  "Only one finally clause can exist in try expression"
                  [])
  (table.insert finally (list 'do ((or table.unpack _G.unpack) form 2))))

(fn add-catch [finally catches form]
  "Appends `catch' body to a sequence of catch bodies that will later
be used in `make-catch-clauses' to produce AST.

Checks if there already was `finally' clause met."
  (assert-compile (= (length finally) 0)
                  "finally clause must be last in try expression"
                  [])
  (table.insert catches (list 'do ((or table.unpack _G.unpack) form 2))))

(fn make-catch-clauses [catches finally]
  "Generates AST of error branches for `match' macro."
  (let [clauses []]
    (var add-catchall? true)
    (each [_ [_ binding-or-val & body] (ipairs catches)]
      (when (sym? binding-or-val)
        (set add-catchall? false))
      (table.insert clauses `(false ,binding-or-val))
      (table.insert clauses `(let [res# ((or table.pack #(doto [$...] (tset :n (select :# $...))))
                                         (do ,((or table.unpack _G.unpack) body)))]
                               ,(. finally 1)
                               (table.unpack res# 1 res#.n))))
    (when add-catchall?
      ;; implicit catchall which retrows error further is added only
      ;; if there were no catch clause that used symbol as catch value
      (table.insert clauses `(false _#))
      (table.insert clauses `(do ,(. finally 1) (error _#))))
    ((or table.unpack _G.unpack) clauses)))

(fn add-to-try [finally catches try form]
  "Append form to the try body.  There must be no `catch' of `finally'
clauses when we push body epression."
  (assert-compile (and (= (length finally) 0)
                       (= (length catches) 0))
                  "Only catch or finally clause can follow catch in try expression"
                  [])
  (table.insert try form))

(fn try [...]
  (let [try '(do)
        catches []
        finally []]
    (each [_ form (ipairs [...])]
      (if (list? form)
          (if (catch? form) (add-catch finally catches form)
              (finally? form) (add-finally finally form)
              (add-to-try finally catches try form))
          (add-to-try finally catches try form)))
    `(match (pcall (fn [] ((or table.pack #(doto [$...] (tset :n (select :# $...)))) ,try)))
       (true _#) (do ,(. finally 1) ((or table.unpack _G.unpack) _# 1 _#.n))
       ,(make-catch-clauses catches finally))))

(attach-meta try {:fnl/arglist [:body* :catch-clause* :finally-clause?]
                  :fnl/docstring "General purpose try/catch/finally macro.
Wraps its body in `pcall' and checks the return value with `match'
macro.

Catch clause is written either as `(catch symbol body*)`, thus acting
as catch-all, or `(catch value body*)` for catching specific errors.
It is possible to have several `catch' clauses.  If no `catch' clauses
specified, an implicit catch-all clause is created.  `body*', and
inner expressions of `catch-clause*', and `finally-clause?' are
wrapped in implicit `do'.

Finally clause is optional, and written as (finally body*).  If
present, it must be the last clause in the `try' form, and the only
`finally' clause.  Note that `finally' clause is for side effects
only, and runs either after succesful run of `try' body, or after any
`catch' clause body, before returning the result.  If no `catch'
clause is provided `finally' runs in implicit catch-all clause, and
trows error to upper scope using `error' function.

To throw error from `try' to catch it with `catch' clause use `error'
or `assert' functions.

# Examples
Catch all errors, ignore those and return fallback value:

``` fennel
(fn add [x y]
  (try
    (+ x y)
    (catch _ 0)))

(assert-eq (add nil 1) 0)
```

Catch error and do cleanup:

``` fennel
(local tbl [])

(try
  (table.insert tbl \"a\")
  (table.insert tbl \"b\" \"c\")
  (catch _
    (each [k _ (pairs tbl)]
      (tset tbl k nil))))

(assert-eq (length tbl) 0)

```

Always run some side effect action:

``` fennel
(local t [])
(local res (try 10 (finally (table.insert t :finally))))
(assert-eq (. t 1) :finally)
(assert-eq res 10)

(local res (try (error 10) (catch 10 nil) (finally (table.insert t :again))))
(assert-eq (. t 2) :again)
(assert-eq res nil)
```
"})


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; loop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn loop [args ...]
  "Recursive loop macro.

Similar to `let`, but binds a special `recur` call that will reassign the values
of the `binding-vec` and restart the loop `body*`.

The first argument is a binding table with alternating symbols (or destructure
forms), and the values to bind to them.

For example:

```fennel
(loop [[first & rest] [1 2 3 4 5]
       i 0]
  (if (= nil first)
      i
      (recur rest (+ 1 i))))
```

This would destructure the first table argument, with the first value inside it
being assigned to `first` and the remainder of the table being assigned to
`rest`. `i` simply gets bound to 0.

The body of the form executes for every item in the table, calling `recur` each
time with the table lacking its head element (thus consuming one element per
iteration), and with `i` being called with one value greater than the previous.

When the loop terminates (When the user doesn't call `recur`) it will return the
number of elements in the passed in table. (In this case, 5)"
  (let [recur (sym :recur)
        keys []
        gensyms []
        bindings []]
    (each [i v (ipairs args)]
      (when (= 0 (% i 2))
        (let [key (. args (- i 1))
              gs (gensym i)]
          ;; Converts a form like
          ;; (loop [[first & rest] (expression)]
          ;;   ...)
          ;;
          ;; to code like:
          ;; (let [sym1# (expression)       ; bindings table
          ;;       [first & rest] sym1#]
          ;;   ((fn recur [[first & rest]]  ; keys table
          ;;      ...)
          ;;     sym1#))                    ; gensyms table, but unpacked
          ;;
          ;; That way it only evaluates once, and so destructuring
          ;; doesn't stomp us.

          ;; [sym1# sym2# etc...], for the function application below
          (table.insert gensyms gs)

          ;; let bindings
          (table.insert bindings gs) ;; sym1#
          (table.insert bindings v) ;; (expression)
          (table.insert bindings key) ;; [first & rest]
          (table.insert bindings gs) ;; sym1#

          ;; The gensyms we use for function application
          (table.insert keys key))))
    `(let ,bindings
       ((fn ,recur ,keys
          ,...)
        ,(table.unpack gensyms)))))

(attach-meta loop {:fnl/arglist [:binding-vec :body*]})


(setmetatable
 {: fn*
  : try
  : if-let
  : when-let
  : if-some
  : when-some
  : empty
  : into
  : with-meta
  : meta
  : defmulti
  : defmethod
  : def
  :defn fn*
  : defonce
  : loop}
 {:__index
  {:_DOC_ORDER [:fn*
                :try
                :def :defonce :defmulti :defmethod
                :into :empty
                :with-meta :meta
                :if-let :when-let :if-some :when-some]
   :_DESCRIPTION "Macros for Cljlib that implement various facilities from Clojure."
   :_MODULE_NAME "macros"}})

;; LocalWords:  arglist fn runtime arities arity multi destructuring
;; LocalWords:  docstring Variadic LocalWords multisym sym tbl eq Lua
;; LocalWords:  defonce metadata metatable fac defmulti Umm defmethod
;; LocalWords:  multimethods multimethod multifn REPL fnl AST Lua's
;; LocalWords:  lua tostring str concat namespace ns Cljlib Clojure
;; LocalWords:  TODO init Andrey Listopadov
