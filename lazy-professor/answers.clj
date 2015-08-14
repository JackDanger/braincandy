(def totals
  (map
    (fn [answers]
      (reduce
        (fn [m answer] (merge-with + m (hash-map answer 1)))
        {}
        answers))
    (apply map list (clojure.string/split (slurp "./test.txt") #"\n"))))

(def bests
  (map
    (fn [counts] (key (apply max-key val counts)))
    totals))

(println "output:" (clojure.string/join bests))
