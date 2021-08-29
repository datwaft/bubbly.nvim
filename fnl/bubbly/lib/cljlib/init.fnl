(local module-info
       {:_MODULE_NAME "cljlib"
        :_DESCRIPTION "Fennel-cljlib - functions from Clojure's core.clj implemented on top
of Fennel.

This library contains a set of functions providing functions that
behave similarly to Clojure's equivalents.  Library itself has nothing
Fennel specific so it should work on Lua, e.g:

``` lua
Lua 5.3.5  Copyright (C) 1994-2018 Lua.org, PUC-Rio
> clj = require\"cljlib\"
> table.concat(clj.mapv(function (x) return x * x end, {1, 2, 3}), \" \")
-- 1 4 9
```

This example is mapping an anonymous `function' over a table,
producing new table and concatenating it with `\" \"`.

However this library also provides Fennel-specific set of
[macros](./macros.md), that provides additional facilities like
`defn' or `defmulti' which extend the language allowing writing code
that looks and works mostly like Clojure.

Each function in this library is created with `defn', which is a
special macros for creating multi-arity functions.  So when you see
function signature like `(foo [x])`, this means that this is function
`foo', that accepts exactly one argument `x'.  In contrary, functions
created with `fn' will produce `(foo x)` signature (`x' is not inside
brackets).

Functions, which signatures look like `(foo ([x]) ([x y]) ([x y &
zs]))`, it is a multi-arity function, which accepts either one, two,
or three-or-more arguments.  Each `([...])` represents different body
of a function which is chosen by checking amount of arguments passed
to the function.  See [Clojure's doc section on multi-arity
functions](https://clojure.org/guides/learn/functions#_multi_arity_functions).

## Compatibility
This library is mainly developed with Lua 5.4, and tested against
Lua 5.2, 5.3, 5.4, and LuaJIT 2.1.0-beta3.  Note, that in lua 5.2 and
LuaJIT equality semantics are a bit different from Lua 5.3 and Lua 5.4.
Main difference is that when comparing two tables, they must have
exactly the same `__eq` metamethods, so comparing hash sets with hash
sets will work, but comparing sets with other tables works only in
Lua5.3+.  Another difference is that Lua 5.2 and LuaJIT don't have
inbuilt UTF-8 library, therefore `seq' function will not work for
non-ASCII strings."})

(local core {})

(local insert table.insert)
(local _unpack (or table.unpack _G.unpack))

(import-macros {: defn : into : empty
                : when-let : if-let : when-some : if-some}
               (if (and ... (not= ... :init)) (.. ... :.bubbly.lib.cljlib.macros) :bubbly.lib.cljlib.macros))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Utility functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn core.apply
  "Apply `f' to the argument list formed by prepending intervening
arguments to `args', and `f' must support variadic amount of
arguments.

# Examples
Applying `add' to different amount of arguments:

``` fennel
(assert-eq (apply add [1 2 3 4]) 10)
(assert-eq (apply add 1 [2 3 4]) 10)
(assert-eq (apply add 1 2 3 4 5 6 [7 8 9]) 45)
```"
  ([f args] (f (_unpack args)))
  ([f a args] (f a (_unpack args)))
  ([f a b args] (f a b (_unpack args)))
  ([f a b c args] (f a b c (_unpack args)))
  ([f a b c d & args]
   (let [flat-args (empty [])]
     (for [i 1 (- (length args) 1)]
       (insert flat-args (. args i)))
     (each [_ a (ipairs (. args (length args)))]
       (insert flat-args a))
     (f a b c d (_unpack flat-args)))))

(defn core.add
  "Sum arbitrary amount of numbers."
  ([] 0)
  ([a] a)
  ([a b] (+ a b))
  ([a b c] (+ a b c))
  ([a b c d] (+ a b c d))
  ([a b c d & rest] (apply add (+ a b c d) rest)))

(defn core.sub
  "Subtract arbitrary amount of numbers."
  ([] 0)
  ([a] (- a))
  ([a b] (- a b))
  ([a b c] (- a b c))
  ([a b c d] (- a b c d))
  ([a b c d & rest] (apply sub (- a b c d) rest)))

(defn core.mul
  "Multiply arbitrary amount of numbers."
  ([] 1)
  ([a] a)
  ([a b] (* a b))
  ([a b c] (* a b c))
  ([a b c d] (* a b c d))
  ([a b c d & rest] (apply mul (* a b c d) rest)))

(defn core.div
  "Divide arbitrary amount of numbers."
  ([a] (/ 1 a))
  ([a b] (/ a b))
  ([a b c] (/ a b c))
  ([a b c d] (/ a b c d))
  ([a b c d & rest] (apply div (/ a b c d) rest)))

(defn core.le
  "Returns true if nums are in monotonically non-decreasing order"
  ([a] true)
  ([a b] (<= a b))
  ([a b & [c d & more]]
   (if (<= a b)
       (if d (apply le b c d more)
           (<= b c))
       false)))

(defn core.lt
  "Returns true if nums are in monotonically decreasing order"
  ([a] true)
  ([a b] (< a b))
  ([a b & [c d & more]]
   (if (< a b)
       (if d (apply lt b c d more)
           (< b c))
       false)))

(defn core.ge
  "Returns true if nums are in monotonically non-increasing order"
  ([a] true)
  ([a b] (>= a b))
  ([a b & [c d & more]]
   (if (>= a b)
       (if d (apply ge b c d more)
           (>= b c))
       false)))

(defn core.gt
  "Returns true if nums are in monotonically increasing order"
  ([a] true)
  ([a b] (> a b))
  ([a b & [c d & more]]
   (if (> a b)
       (if d (apply gt b c d more)
           (> b c))
       false)))

(defn core.inc "Increase number `x' by one" [x] (+ x 1))
(defn core.dec "Decrease number `x' by one" [x] (- x 1))

(local utility-doc-order
       [:apply :add :sub :mul :div :le :lt :ge :gt :inc :dec])


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tests and predicates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn fast-table-type [tbl]
  (-?> tbl getmetatable (. :cljlib/type)))

(defn core.map?
  "Check whether `tbl' is an associative table.

Non empty associative tables are tested for two things:
- `next' returns the key-value pair,
- key, that is returned by the `next' is not equal to `1`.

Empty tables can't be analyzed with this method, and `map?' will
return `false'.  If you need this test pass for empty table, see
`hash-map' for creating tables that have additional
metadata attached for this test to work.

# Examples
Non empty tables:

``` fennel
(assert-is (map? {:a 1 :b 2}))

(local some-table {:key :value})
(assert-is (map? some-table))
```

Empty tables:

``` fennel
(local some-table {})
(assert-not (map? some-table))
```

Empty tables created with `hash-map' will pass the test:

``` fennel
(local some-table (hash-map))
(assert-is (map? some-table))
```"
  [tbl]
  (if (= (type tbl) :table)
      (if-let [t (fast-table-type tbl)]
        (= t :table)
        (let [(k _) (next tbl)]
          (and (not= k nil)
               (not= k 1))))))

(defn core.vector?
  "Check whether `tbl' is an sequential table.

Non empty sequential tables are tested for two things:
- `next' returns the key-value pair,
- key, that is returned by the `next' is equal to `1`.

Empty tables can't be analyzed with this method, and `vector?' will
always return `false'.  If you need this test pass for empty table,
see `vector' for creating tables that have additional
metadata attached for this test to work.

# Examples
Non empty vector:

``` fennel
(assert-is (vector? [1 2 3 4]))

(local some-table [1 2 3])
(assert-is (vector? some-table))
```

Empty tables:

``` fennel
(local some-table [])
(assert-not (vector? some-table))
```

Empty tables created with `vector' will pass the test:

``` fennel
(local some-table (vector))
(assert-is (vector? some-table))
```"
  [tbl]
  (if (= (type tbl) :table)
      (if-let [t (fast-table-type tbl)]
        (= t :seq)
        (let [(k _) (next tbl)]
          (and (not= k nil) (= k 1))))))

(defn core.multifn?
  "Test if `mf' is an instance of `multifn'.

`multifn' is a special kind of table, created with `defmulti' macros
from `macros.fnl'."
  [mf]
  (= (. (or (getmetatable mf) {}) :cljlib/type) :multifn))

(defn core.set?
  "Test if `s` is either instance of a `hash-set' or `ordered-set'."
  [s]
  (match (. (or (getmetatable s) {}) :cljlib/type)
    :cljlib/ordered-set :cljlib/ordered-set
    :cljlib/hash-set :cljlib/hash-set
    _ false))

(defn core.nil?
  "Test if `x' is nil."
  ([] true)
  ([x] (= x nil)))

(defn core.zero?
  "Test if `x' is equal to zero."
  [x]
  (= x 0))

(defn core.pos?
  "Test if `x' is greater than zero."
  [x]
  (> x 0))

(defn core.neg?
  "Test if `x' is less than zero."
  [x]
  (< x 0))

(defn core.even?
  "Test if `x' is even."
  [x]
  (= (% x 2) 0))

(defn core.odd?
  "Test if `x' is odd."
  [x]
  (not (even? x)))

(defn core.string?
  "Test if `x' is a string."
  [x]
  (= (type x) :string))

(defn core.boolean?
  "Test if `x' is a Boolean"
  [x]
  (= (type x) :boolean))

(defn core.true?
  "Test if `x' is `true'"
  [x]
  (= x true))

(defn core.false?
  "Test if `x' is `false'"
  [x]
  (= x false))

(defn core.int?
  "Test if `x' is a number without floating point data.

Number is rounded with `math.floor' and compared with original number."
  [x]
  (and (= (type x) :number)
       (= x (math.floor x))))

(defn core.pos-int?
  "Test if `x' is a positive integer."
  [x]
  (and (int? x)
       (pos? x)))

(defn core.neg-int?
  "Test if `x' is a negative integer."
  [x]
  (and (int? x)
       (neg? x)))

(defn core.double?
  "Test if `x' is a number with floating point data."
  [x]
  (and (= (type x) :number)
       (not= x (math.floor x))))

(defn core.empty?
  "Check if collection is empty."
  [x]
  (match (type x)
    :table (= (next x) nil)
    :string (= x "")
    _ (error "empty?: unsupported collection")))

(defn core.not-empty
  "If `x' is empty, returns `nil', otherwise `x'."
  [x]
  (if (not (empty? x))
      x))

(local predicate-doc-order
       [:map? :vector? :multifn? :set? :nil? :zero? :pos?
        :neg? :even? :odd? :string? :boolean? :true? :false?
        :int? :pos-int? :neg-int? :double? :empty? :not-empty])


;;;;;;;;;;;;;;;;;;;;;; Sequence manipulation functions ;;;;;;;;;;;;;;;;;;;;;;;;;

(defn core.vector
  "Constructs sequential table out of it's arguments.

Sets additional metadata for function `vector?' to work.

# Examples

``` fennel
(local v (vector 1 2 3 4))
(assert-eq v [1 2 3 4])
```"
  [& args]
  (setmetatable args {:cljlib/type :seq}))

(defn core.seq
  "Create sequential table.

Transforms original table to sequential table of key value pairs
stored as sequential tables in linear time.  If `col' is an
associative table, returns sequential table of vectors with key and
value.  If `col' is sequential table, returns its shallow copy.  If
`col' is string, return sequential table of its codepoints.

# Examples
Sequential tables remain as is:

``` fennel
(seq [1 2 3 4])
;; [1 2 3 4]
```

Associative tables are transformed to format like this `[[key1 value1]
... [keyN valueN]]` and order is non deterministic:

``` fennel
(seq {:a 1 :b 2 :c 3})
;; [[:b 2] [:a 1] [:c 3]]
```

See `into' macros for transforming this back to associative table.
Additionally you can use `conj' and `apply' with
`hash-map':

``` fennel
(apply conj (hash-map) [:c 3] [[:a 1] [:b 2]])
;; => {:a 1 :b 2 :c 3}
```"
  [col]
  (let [res (empty [])]
    (match (type col)
      :table (let [m (or (getmetatable col) {})]
               (when-some [_ ((or m.cljlib/next next) col)]
                 (var assoc? false)
                 (let [assoc-res (empty [])]
                   (each [k v (pairs col)]
                     (if (and (not assoc?)
                              (map? col))
                         (set assoc? true))
                     (insert res v)
                     (insert assoc-res [k v]))
                   (if assoc? assoc-res res))))
      :string (if _G.utf8
                  (let [char _G.utf8.char]
                    (each [_ b (_G.utf8.codes col)]
                      (insert res (char b)))
                    res)
                  (do (io.stderr:write
                       "WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
                      (each [b (col:gmatch ".")]
                        (insert res b))
                      res))
      :nil nil
      _ (error (.. "expected table, string or nil, got " (type col)) 2))))

(defn core.kvseq
  "Transforms any table `col' to key-value sequence."
  [col]
  (let [res (empty [])]
    (match (type col)
      :table (let [m (or (getmetatable col) {})]
               (when-some [_ ((or m.cljlib/next next) col)]
                 (each [k v (pairs col)]
                   (insert res [k v]))
                 res))
      :string (if _G.utf8
                  (let [char _G.utf8.char]
                    (each [i b (_G.utf8.codes col)]
                      (insert res [i (char b)]))
                    res)
                  (do (io.stderr:write
                       "WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
                      (for [i 1 (length col)]
                        (insert res [i (col:sub i i)]))
                      res))
      :nil nil
      _ (error (.. "expected table, string or nil, got " (type col)) 2))))

(defn core.first
  "Return first element of a table. Calls `seq' on its argument."
  [col]
  (when-some [col (seq col)]
    (. col 1)))

(defn core.rest
  "Returns table of all elements of a table but the first one. Calls
  `seq' on its argument."
  [col]
  (if-some [col (seq col)]
    (vector (_unpack col 2))
    (empty [])))

(defn core.last
  "Returns the last element of a table. Calls `seq' on its argument."
  [col]
  (when-some [col (seq col)]
    (var (i v) (next col))
    (while i
      (local (_i _v) (next col i))
      (if _i (set v _v))
      (set i _i))
    v))

(defn core.butlast
  "Returns everything but the last element of a table as a new
  table. Calls `seq' on its argument."
  [col]
  (when-some [col (seq col)]
    (table.remove col (length col))
    (when (not (empty? col))
      col)))

(defn core.conj
  "Insert `x' as a last element of a table `tbl'.

If `tbl' is a sequential table or empty table, inserts `x' and
optional `xs' as final element in the table.

If `tbl' is an associative table, that satisfies `map?' test,
insert `[key value]` pair into the table.

Mutates `tbl'.

# Examples
Adding to sequential tables:

``` fennel
(conj [] 1 2 3 4)
;; => [1 2 3 4]
(conj [1 2 3] 4 5)
;; => [1 2 3 4 5]
```

Adding to associative tables:

``` fennel
(conj {:a 1} [:b 2] [:c 3])
;; => {:a 1 :b 2 :c 3}
```

Note, that passing literal empty associative table `{}` will not work:

``` fennel
(conj {} [:a 1] [:b 2])
;; => [[:a 1] [:b 2]]
(conj (hash-map) [:a 1] [:b 2])
;; => {:a 1 :b 2}
```

See `hash-map' for creating empty associative tables."
  ([] (empty []))
  ([tbl] tbl)
  ([tbl x]
   (when-some [x x]
     (let [tbl (or tbl (empty []))]
       (if (map? tbl)
           (tset tbl (. x 1) (. x 2))
           (tset tbl (+ 1 (length tbl)) x))))
   tbl)
  ([tbl x & xs]
   (apply conj (conj tbl x) xs)))

(defn core.disj
  "Remove key `k' from set `s'."
  ([s] (if (set? s) s
           (error "expected either hash-set or ordered-set as first argument" 2)))
  ([s k]
   (if (set? s)
       (doto s (tset k nil))
       (error "expected either hash-set or ordered-set as first argument" 2)))
  ([s k & ks]
   (apply disj (disj s k) ks)))

(fn consj [...]
  "Like conj but joins at the front. Modifies `tbl'."
  (let [[tbl x & xs] [...]]
    (if (nil? x) tbl
        (consj (doto tbl (insert 1 x)) (_unpack xs)))))

(defn core.cons
  "Insert `x' to `tbl' at the front.  Calls `seq' on `tbl'."
  [x tbl]
  (if-some [x x]
    (doto (or (seq tbl) (empty []))
      (insert 1 x))
    tbl))

(defn core.concat
  "Concatenate tables."
  ([] nil)
  ([x] (or (seq x) (empty [])))
  ([x y] (let [to (or (seq x) (empty []))
               from (or (seq y) (empty []))]
           (each [_ v (ipairs from)]
             (insert to v))
           to))
  ([x y & xs]
   (apply concat (concat x y) xs)))

(defn core.reduce
  "Reduce collection `col' using function `f' and optional initial value `val'.

`f' should be a function of 2 arguments.  If val is not supplied,
returns the result of applying f to the first 2 items in coll, then
applying f to that result and the 3rd item, etc.  If coll contains no
items, f must accept no arguments as well, and reduce returns the
result of calling f with no arguments.  If coll has only 1 item, it is
returned and f is not called.  If val is supplied, returns the result
of applying f to val and the first item in coll, then applying f to
that result and the 2nd item, etc.  If coll contains no items, returns
val and f is not called.  Calls `seq' on `col'.

Early termination is possible with the use of `reduced'
function.

# Examples
Reduce sequence of numbers with `add'

``` fennel
(reduce add [1 2 3 4])
;; => 10
(reduce add 10 [1 2 3 4])
;; => 20
```"
  ([f col]
   (let [col (or (seq col) (empty []))]
     (match (length col)
       0 (f)
       1 (. col 1)
       2 (f (. col 1) (. col 2))
       _ (let [[a b & rest] col]
           (reduce f (f a b) rest)))))
  ([f val col]
   (let [m (getmetatable val)]
     (if (and m
              m.cljlib/reduced
              (= m.cljlib/reduced.status :ready))
         m.cljlib/reduced.val
         (let [col (or (seq col) (empty []))]
           (let [[x & xs] col]
             (if (nil? x)
                 val
                 (reduce f (f val x) xs))))))))

(defn core.reduced
  "Wraps `x' in such a way so `reduce' will terminate early
with this value.

# Examples
Stop reduction is result is higher than `10`:

``` fennel
(reduce (fn [res x]
          (if (>= res 10)
              (reduced res)
              (+ res x)))
        [1 2 3])
;; => 6

(reduce (fn [res x]
          (if (>= res 10)
              (reduced res)
              (+ res x)))
        [1 2 3 4 :nil])
;; => 10
```

Note that in second example we had `:nil` in the array, which is not a
valid number, but we've terminated right before we've reached it."
  [x]
  (setmetatable
   {} {:cljlib/reduced {:status :ready
                        :val x}}))

(defn core.reduce-kv
  "Reduces an associative table using function `f' and initial value `val'.

`f' should be a function of 3 arguments.  Returns the result of
applying `f' to `val', the first key and the first value in `tbl',
then applying `f' to that result and the 2nd key and value, etc.  If
`tbl' contains no entries, returns `val' and `f' is not called.  Note
that reduce-kv is supported on sequential tables and strings, where
the keys will be the ordinals.

Early termination is possible with the use of `reduced'
function.

# Examples
Reduce associative table by adding values from all keys:

``` fennel
(local t {:a1 1
          :b1 2
          :a2 2
          :b2 3})

(reduce-kv #(+ $1 $3) 0 t)
;; => 8
```

Reduce table by adding values from keys that start with letter `a':

``` fennel
(local t {:a1 1
          :b1 2
          :a2 2
          :b2 3})

(reduce-kv (fn [res k v] (if (= (string.sub k 1 1) :a) (+ res v) res))
           0 t)
;; => 3
```"
  [f val tbl]
  (var res val)
  (each [_ [k v] (ipairs (or (kvseq tbl) (empty [])))]
    (set res (f res k v))
    (match (getmetatable res)
      m (if (and m.cljlib/reduced
                 (= m.cljlib/reduced.status :ready))
            (do (set res m.cljlib/reduced.val)
                (lua :break)))))
  res)

(defn core.mapv
  "Maps function `f' over one or more collections.

Accepts arbitrary amount of collections, calls `seq' on each of it.
Function `f' must take the same amount of arguments as the amount of
tables, passed to `mapv'. Applies `f' over first value of each
table. Then applies `f' to second value of each table. Continues until
any of the tables is exhausted. All remaining values are
ignored. Returns a sequential table of results.

# Examples
Map `string.upcase' over the string:

``` fennel
(mapv string.upper \"string\")
;; => [\"S\" \"T\" \"R\" \"I\" \"N\" \"G\"]
```

Map `mul' over two tables:

``` fennel
(mapv mul [1 2 3 4] [1 0 -1])
;; => [1 0 -3]
```

Basic `zipmap' implementation:

``` fennel
(import-macros {: into} :bubbly.lib.cljlib.macros)
(fn zipmap [keys vals]
  (into {} (mapv vector keys vals)))

(zipmap [:a :b :c] [1 2 3 4])
;; => {:a 1 :b 2 :c 3}
```"
  ([f col]
   (local res (empty []))
   (each [_ v (ipairs (or (seq col) (empty [])))]
     (when-some [tmp (f v)]
       (insert res tmp)))
   res)
  ([f col1 col2]
   (let [res (empty [])
         col1 (or (seq col1) (empty []))
         col2 (or (seq col2) (empty []))]
     (var (i1 v1) (next col1))
     (var (i2 v2) (next col2))
     (while (and i1 i2)
       (when-some [tmp (f v1 v2)]
         (insert res tmp))
       (set (i1 v1) (next col1 i1))
       (set (i2 v2) (next col2 i2)))
     res))
  ([f col1 col2 col3]
   (let [res (empty [])
         col1 (or (seq col1) (empty []))
         col2 (or (seq col2) (empty []))
         col3 (or (seq col3) (empty []))]
     (var (i1 v1) (next col1))
     (var (i2 v2) (next col2))
     (var (i3 v3) (next col3))
     (while (and i1 i2 i3)
       (when-some [tmp (f v1 v2 v3)]
         (insert res tmp))
       (set (i1 v1) (next col1 i1))
       (set (i2 v2) (next col2 i2))
       (set (i3 v3) (next col3 i3)))
     res))
  ([f col1 col2 col3 & cols]
   (let [step (fn step [cols]
                (if (->> cols
                         (mapv #(not= (next $) nil))
                         (reduce #(and $1 $2)))
                    (cons (mapv #(. (or (seq $) (empty [])) 1) cols)
                          (step (mapv #(do [(_unpack $ 2)]) cols)))
                    (empty [])))
         res (empty [])]
     (each [_ v (ipairs (step (consj cols col3 col2 col1)))]
       (when-some [tmp (apply f v)]
         (insert res tmp)))
     res)))

(defn core.filter
  "Returns a sequential table of the items in `col' for which `pred'
  returns logical true."
  [pred col]
  (if-let [col (seq col)]
    (let [f (. col 1)
          r [(_unpack col 2)]]
      (if (pred f)
          (cons f (filter pred r))
          (filter pred r)))
    (empty [])))

(defn core.every?
  "Test if every item in `tbl' satisfies the `pred'."
  [pred tbl]
  (if (empty? tbl) true
      (pred (. tbl 1)) (every? pred [(_unpack tbl 2)])
      false))

(defn core.some
  "Test if any item in `tbl' satisfies the `pred'."
  [pred tbl]
  (when-let [tbl (seq tbl)]
    (or (pred (. tbl 1)) (some pred [(_unpack tbl 2)]))))

(defn core.not-any?
  "Test if no item in `tbl' satisfy the `pred'."
  [pred tbl]
  (some #(not (pred $)) tbl))

(defn core.range
  "return range of of numbers from `lower' to `upper' with optional `step'."
  ([upper] (range 0 upper 1))
  ([lower upper] (range lower upper 1))
  ([lower upper step]
   (let [res (empty [])]
     (for [i lower (- upper step) step]
       (insert res i))
     res)))

(defn core.reverse
  "Returns table with same items as in `tbl' but in reverse order."
  [tbl]
  (when-some [tbl (seq tbl)]
    (reduce consj (empty []) tbl)))

(defn core.take
  "Returns a sequence of the first `n' items in `col', or all items if
there are fewer than `n'."
  [n col]
  (if (= n 0)
      []
      (pos-int? n)
      (if-let [s (seq col)]
        (cons (first s) (take (dec n) (rest s)))
        nil)
      (error "expected positive integer as first argument" 2)))

(defn core.nthrest
  "Returns the nth rest of `col', `col' when `n' is 0.

# Examples

``` fennel
(assert-eq (nthrest [1 2 3 4] 3) [4])
(assert-eq (nthrest [1 2 3 4] 2) [3 4])
(assert-eq (nthrest [1 2 3 4] 1) [2 3 4])
(assert-eq (nthrest [1 2 3 4] 0) [1 2 3 4])
```
"
  [col n]
  [(_unpack col (inc n))])

(defn core.partition
  "Returns a sequence of sequences of `n' items each, at offsets step
apart. If `step' is not supplied, defaults to `n', i.e. the partitions
do not overlap. If a `pad' collection is supplied, use its elements as
necessary to complete last partition up to `n' items. In case there
are not enough padding elements, return a partition with less than `n'
items.

# Examples
Partition sequence into sub-sequences of size 3:

``` fennel
(assert-eq (partition 3 [1 2 3 4 5 6]) [[1 2 3] [4 5 6]])
```

When collection doesn't have enough elements, partition will not include those:

``` fennel
(assert-eq (partition 3 [1 2 3 4]) [[1 2 3]])
```

Partitions can overlap if step is supplied:

``` fennel
(assert-eq (partition 2 1 [1 2 3 4]) [[1 2] [2 3] [3 4]])
```

Additional padding can be used to supply insufficient elements:

``` fennel
(assert-eq (partition 3 3 [3 2 1] [1 2 3 4]) [[1 2 3] [4 3 2]])
```"
  ([n col]
   (partition n n col))
  ([n step col]
   (if-let [s (seq col)]
     (let [p (take n s)]
       (if (= n (length p))
           (cons p (partition n step (nthrest s step)))
           nil))
     nil))
  ([n step pad col]
   (if-let [s (seq col)]
     (let [p (take n s)]
       (if (= n (length p))
           (cons p (partition n step pad (nthrest s step)))
           [(take n (concat p pad))]))
     nil)))

(local sequence-doc-order
       [:vector :seq :kvseq :first :rest :last :butlast
        :conj :disj :cons :concat :reduce :reduced :reduce-kv
        :mapv :filter :every? :some :not-any? :range :reverse :take
        :nthrest :partition])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(var eq nil)

(fn deep-index [tbl key]
  "This function uses the pre-declared `eq', which we set later on,
because `eq' requires this function internally.  Several other
functions also reuse this indexing method, such as sets."
  (var res nil)
  (each [k v (pairs tbl)]
    (when (eq k key)
      (set res v)
      (lua :break)))
  res)

(defn _eq
  "Deep compare values.

# Examples

`eq' can compare both primitive types, tables, and user defined types
that have `__eq` metamethod.

``` fennel
(assert-is (eq 42 42))
(assert-is (eq [1 2 3] [1 2 3]))
(assert-is (eq (hash-set :a :b :c) (hash-set :a :b :c)))
(assert-is (eq (hash-set :a :b :c) (ordered-set :c :b :a)))
```

Deep comparison is used for tables which use tables as keys:

``` fennel
(assert-is (eq {[1 2 3] {:a [1 2 3]} {:a 1} {:b 2}}
               {{:a 1} {:b 2} [1 2 3] {:a [1 2 3]}}))
(assert-is (eq {{{:a 1} {:b 1}} {{:c 3} {:d 4}} [[1] [2 [3]]] {:a 2}}
               {[[1] [2 [3]]] {:a 2} {{:a 1} {:b 1}} {{:c 3} {:d 4}}}))
```"
  ([x] true)
  ([x y]
   (if (= x y)
       true
       (and (= (type x) :table) (= (type y) :table))
       (do (var [res count-a count-b] [true 0 0])
           (each [k v (pairs x)]
             (set res (eq v (deep-index y k)))
             (set count-a (+ count-a 1))
             (when (not res) (lua :break)))
           (when res
             (each [_ _ (pairs y)]
               (set count-b (+ count-b 1)))
             (set res (= count-a count-b)))
           res)
       :else
       false))
  ([x y & xs]
   (and (eq x y) (apply eq x xs))))

(set eq _eq)
(set core.eq _eq)

;;;;;;;;;;;;;;;;;;;;;; Function manipulation functions ;;;;;;;;;;;;;;;;;;;;;;;;;

(defn core.identity "Returns its argument." [x] x)

(defn core.comp
  "Compose functions."
  ([] identity)
  ([f] f)
  ([f g]
   (defn
    ([] (f (g)))
    ([x] (f (g x)))
    ([x y] (f (g x y)))
    ([x y z] (f (g x y z)))
    ([x y z & args] (f (g x y z (_unpack args))))))
  ([f g & fs]
   (reduce comp (consj fs g f))))

(defn core.complement
  "Takes a function `f' and returns the function that takes the same
amount of arguments as `f', has the same effect, and returns the
oppisite truth value."
  [f]
  (defn
   ([] (not (f)))
   ([a] (not (f a)))
   ([a b] (not (f a b)))
   ([a b & cs] (not (apply f a b cs)))))

(defn core.constantly
  "Returns a function that takes any number of arguments and returns `x'."
  [x]
  (fn [] x))

(defn core.memoize
  "Returns a memoized version of a referentially transparent function.
The memoized version of the function keeps a cache of the mapping from
arguments to results and, when calls with the same arguments are
repeated often, has higher performance at the expense of higher memory
use."
  [f]
  (let [memo (setmetatable {} {:__index deep-index})]
    (fn [...]
      (let [args [...]]
        (if-some [res (. memo args)]
          res
          (let [res (f ...)]
            (tset memo args res)
            res))))))

(local function-manipulation-doc-order
       [:identity :comp :complement :constantly :memoize])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Hash table extras ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn core.assoc
  "Associate key `k' with value `v' in `tbl'."
  ([tbl k v]
   (assert (not (nil? k)) "attempt to use nil as key")
   (setmetatable
    (doto tbl (tset k v))
    {:cljlib/type :table}))
  ([tbl k v & kvs]
   (assert (= (% (length kvs) 2) 0)
           (.. "no value supplied for key " (. kvs (length kvs))))
   (assert (not (nil? k)) "attempt to use nil as key")
   (tset tbl k v)
   (var [k v] [nil nil])
   (var (i k) (next kvs))
   (while i
     (set (i v) (next kvs i))
     (tset tbl k v)
     (set (i k) (next kvs i)))
   (setmetatable tbl {:cljlib/type :table})))

(defn core.hash-map
  "Create associative table from `kvs' represented as sequence of keys
and values"
  ([] (empty {}))
  ([& kvs] (apply assoc {} kvs)))

(defn core.get
  "Get value from the table by accessing it with a `key'.
Accepts additional `not-found' as a marker to return if value wasn't
found in the table."
  ([tbl key] (get tbl key nil))
  ([tbl key not-found]
   (if-some [res (. tbl key)]
     res
     not-found)))

(defn core.get-in
  "Get value from nested set of tables by providing key sequence.
Accepts additional `not-found' as a marker to return if value wasn't
found in the table."
  ([tbl keys] (get-in tbl keys nil))
  ([tbl keys not-found]
   (var res tbl)
   (var t tbl)
   (each [_ k (ipairs keys)]
     (if-some [v (. t k)]
       (set [res t] [v v])
       (set res not-found)))
   res))

(defn core.keys
  "Returns a sequence of the table's keys, in the same order as `seq'."
  [tbl]
  (let [res []]
    (each [k _ (pairs tbl)]
      (insert res k))
    res))

(defn core.vals
  "Returns a sequence of the table's values, in the same order as `seq'."
  [tbl]
  (let [res []]
    (each [_ v (pairs tbl)]
      (insert res v))
    res))

(defn core.find
  "Returns the map entry for `key', or `nil' if key not present in `tbl'."
  [tbl key]
  (when-some [v (. tbl key)]
    [key v]))

(defn core.dissoc
  "Remove `key' from table `tbl'.  Optionally takes more `keys`."
  ([tbl] tbl)
  ([tbl key]
   (doto tbl (tset key nil)))
  ([tbl key & keys]
   (apply dissoc (dissoc tbl key) keys)))

(local hash-table-doc-order
       [:assoc :hash-map :get :get-in :keys :vals :find :dissoc])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Multimethods ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn core.remove-method
  "Remove method from `multimethod' for given `dispatch-value'."
  [multimethod dispatch-value]
  (if (multifn? multimethod)
      (tset multimethod dispatch-value nil)
      (error (.. (tostring multimethod) " is not a multifn") 2))
  multimethod)

(defn core.remove-all-methods
  "Removes all of the methods of `multimethod'"
  [multimethod]
  (if (multifn? multimethod)
      (each [k _ (pairs multimethod)]
        (tset multimethod k nil))
      (error (.. (tostring multimethod) " is not a multifn") 2))
  multimethod)

(defn core.methods
  "Given a `multimethod', returns a map of dispatch values -> dispatch fns"
  [multimethod]
  (if (multifn? multimethod)
      (let [m {}]
        (each [k v (pairs multimethod)]
          (tset m k v))
        m)
      (error (.. (tostring multimethod) " is not a multifn") 2)))

(defn core.get-method
  "Given a `multimethod' and a `dispatch-value', returns the dispatch
`fn' that would apply to that value, or `nil' if none apply and no
default."
  [multimethod dispatch-value]
  (if (multifn? multimethod)
      (or (. multimethod dispatch-value)
          (. multimethod :default))
      (error (.. (tostring multimethod) " is not a multifn") 2)))

(local multimethods-doc-order
       [:remove-method :remove-all-methods :methods :get-method])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Sets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn viewset [Set view inspector indent]
  (if (. inspector.seen Set)
      (.. "@set" (. inspector.seen Set) "{...}")
      (let [prefix (.. "@set"
                       (if (inspector.visible-cycle? Set)
                           (. inspector.seen Set) "")
                       "{")
            set-indent (length prefix)
            indent-str (string.rep " " set-indent)
            lines (icollect [v (pairs Set)]
                    (.. indent-str
                        (view v inspector (+ indent set-indent) true)))]
        (tset lines 1 (.. prefix (string.gsub (or (. lines 1) "") "^%s+" "")))
        (tset lines (length lines) (.. (. lines (length lines)) "}"))
        lines)))

(fn ordered-set-newindex [Set]
  "`__newindex` metamethod for ordered-set.

Updates order of all items when some key removed from set."
  (fn [t k v]
    (if (= nil v)
        (let [k (. Set k)]
          (each [key index (pairs Set)]
            (if (= index k) (tset Set key nil)
                (> index k) (tset Set key (- index 1)))))
        (if (not (. Set v))
            (tset Set v (+ 1 (length t)))))))

(fn hash-set-newindex [Set]
  "`__newindex` metamethod for hash-set."
  (fn [t k v]
    (if (= nil v)
        (each [key _ (pairs Set)]
          (when (eq key k)
            (tset Set key nil)
            (lua :break)))
        (if (not (. Set v))
            (tset Set v true)))))

(fn set-length [Set]
  "`__len` metamethod for set data structure."
  (fn []
    (var len 0)
    (each [_ _ (pairs Set)]
      (set len (+ 1 len)))
    len))

(fn set-eq [s1 s2]
  "`__eq` metamethod for set data structure."
  (var [size res] [0 true])
  (each [i k (pairs s1)]
    (set size (+ size 1))
    (if res (set res (. s2 k))
        (lua :break)))
  (and res (= size (length s2))))

(fn set->iseq [Set]
  (collect [v k (pairs Set)]
    (values k v)))

(fn ordered-set-pairs [Set]
  "Returns stateless `ipairs' iterator for ordered sets."
  (fn []
    (var i 0)
    (var iseq nil)
    (fn set-next [t _]
      (when (not iseq)
        (set iseq (set->iseq Set)))
      (set i (+ i 1))
      (let [v (. iseq i)]
        (values v v)))
    (values set-next Set nil)))

(fn hash-set-pairs [Set]
  "Returns stateful `ipairs' iterator for hashed sets."
  (fn []
    (fn iter [t k]
      (let [v (next t k)]
        (values v v)))
    (values iter Set nil)))

(fn into-set [Set tbl]
  "Transform `tbl' into `Set`"
  (each [_ v (pairs (or (seq tbl) []))]
    (conj Set v))
  Set)

;; Sets are bootstrapped upon previous functions.

(defn core.ordered-set
  "Create ordered set.

Set is a collection of unique elements, which sore purpose is only to
tell you if something is in the set or not.

`ordered-set' is follows the argument insertion order, unlike sorted
sets, which apply some sorting algorithm internally. New items added
at the end of the set. Ordered set supports removal of items via
`tset' and `disj'. To add element to the ordered set use
`tset' or `conj'. Both operations modify the set.

**Note**: Hash set prints as `@set{a b c}`, but this construct is not
supported by the Fennel reader, so you can't create sets with this
syntax. Use `ordered-set' function instead.

Below are some examples of how to create and manipulate sets.

## Create ordered set:
Ordered sets are created by passing any amount of elements desired to
be in the set:

``` fennel
(ordered-set)
;; => @set{}
(ordered-set :a :c :b)
;; => @set{:a :c :b}
```

Duplicate items are not added:

``` fennel
(ordered-set :a :c :a :a :a :a :c :b)
;; => @set{:a :c :b}
```

## Check if set contains desired value:
Sets are functions of their keys, so simply calling a set with a
desired key will either return the key, or `nil':

``` fennel
(local oset (ordered-set [:a :b :c] [:c :d :e] :e :f))
(oset [:a :b :c])
;; => [\"a\" \"b\" \"c\"]
(. oset :e)
;; \"e\"
(oset [:a :b :f])
;; => nil
```

## Add items to existing set:
To add element to the set use `conj' or `tset'

``` fennel
(local oset (ordered-set :a :b :c))
(conj oset :d :e)
;; => @set{:a :b :c :d :e}
```

### Remove items from the set:
To add element to the set use `disj' or `tset'

``` fennel
(local oset (ordered-set :a :b :c))
(disj oset :b)
;; => @set{:a :c}
(tset oset :a nil)
oset
;; => @set{:c}
```

## Equality semantics
Both `ordered-set' and `hash-set' implement `__eq` metamethod,
and are compared for having the same keys without particular order and
same size:

``` fennel
(assert-eq (ordered-set :a :b) (ordered-set :b :a))
(assert-ne (ordered-set :a :b) (ordered-set :b :a :c))
(assert-eq (ordered-set :a :b) (hash-set :a :b))
```"
  [& xs]
  (let [Set (setmetatable {} {:__index deep-index})
        set-pairs (ordered-set-pairs Set)]
    (var i 1)
    (each [_ val (ipairs xs)]
      (when (not (. Set val))
        (tset Set val i)
        (set i (+ 1 i))))
    (setmetatable {}
                  {:cljlib/type :cljlib/ordered-set
                   :cljlib/next #(next Set $2)
                   :cljlib/into into-set
                   :cljlib/empty #(ordered-set)
                   :__eq set-eq
                   :__call #(if (. Set $2) $2 nil)
                   :__len (set-length Set)
                   :__index #(if (. Set $2) $2 nil)
                   :__newindex (ordered-set-newindex Set)
                   :__pairs set-pairs
                   :__name "ordered set"
                   :__fennelview viewset})))

(defn core.hash-set
  "Create hash set.

Set is a collection of unique elements, which sore purpose is only to
tell you if something is in the set or not.

Hash set differs from ordered set in that the keys are do not have any
particular order. New items are added at the arbitrary position by
using `conj' or `tset' functions, and items can be removed
with `disj' or `tset' functions. Rest semantics are the same
as for `ordered-set'

**Note**: Hash set prints as `@set{a b c}`, but this construct is not
supported by the Fennel reader, so you can't create sets with this
syntax. Use `hash-set' function instead."
  [& xs]
  (let [Set (setmetatable {} {:__index deep-index})
        set-pairs (hash-set-pairs Set)]
    (each [_ val (ipairs xs)]
      (when (not (. Set val))
        (tset Set val true)))
    (setmetatable {}
                  {:cljlib/type :cljlib/hash-set
                   :cljlib/next #(next Set $2)
                   :cljlib/into into-set
                   :cljlib/empty #(hash-set)
                   :__eq set-eq
                   :__call #(if (. Set $2) $2 nil)
                   :__len (set-length Set)
                   :__index #(if (. Set $2) $2 nil)
                   :__newindex (hash-set-newindex Set)
                   :__pairs set-pairs
                   :__name "hash set"
                   :__fennelview viewset})))

(local set-doc-order
       [:ordered-set :hash-set])


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Module info and export ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set module-info._DOC_ORDER (concat utility-doc-order
                                    [:eq]
                                    predicate-doc-order
                                    sequence-doc-order
                                    function-manipulation-doc-order
                                    hash-table-doc-order
                                    multimethods-doc-order
                                    set-doc-order))

(setmetatable core {:__index module-info})


;; LocalWords:  cljlib Clojure's clj lua PUC mapv concat Clojure fn zs
;; LocalWords:  defmulti multi arity eq metadata prepending variadic
;; LocalWords:  args tbl LocalWords memoized referentially Andrey
;; LocalWords:  Orst codepoints Listopadov metamethods nums multifn
;; LocalWords:  stateful LuaJIT
