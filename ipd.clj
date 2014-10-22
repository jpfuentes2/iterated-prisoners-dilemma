(defn prisoner [name strategy]
  {:name name :strategy strategy :moves '() :scores '() :total-score 0})

(def defect 0)

(def cooperate 1)

(defn AlwaysDefect [mover opponent]
  defect)

(defn AlwaysCooperate [mover opponent]
  cooperate)

(defn game [& prisoners]
  (map (fn [mover opponent]
         (->> (map :moves [mover, opponent])
              (apply (:strategy mover))
              (update-in mover [:moves] conj)))
        prisoners
        (reverse prisoners)))

(defn iterated-game [iterations & prisoners]
  (reduce (fn [ps _] (apply game ps))
          prisoners
          (range 0 iterations)))

(def scores {[1 0] 0
             [0 0] 1
             [1 1] 3
             [0 1] 5})

(defn compute-scores [prisoners moves]
  (map (fn [prisoner moves]
         (let [point (get scores moves)
               scores (:scores prisoner)
               total (:total-score prisoner)]
           (assoc prisoner
             :scores (conj scores point)
             :total-score (+ total point))))
       prisoners
       [moves (reverse moves)]))

(defn total-scores [& prisoners]
  (let [move-pairs (->> (map :moves prisoners)
                        (apply interleave)
                        (partition 2))]
    (reduce compute-scores prisoners move-pairs)))

(->> [(prisoner :a AlwaysCooperate) (prisoner :b AlwaysDefect)]
     (apply iterated-game 10)
     (apply total-scores)
     (map (fn [prisoner]
            (format "Prisoner %s (%s): %d"
                    (-> (:name prisoner) name .toUpperCase)
                    (->> (:strategy prisoner) str (re-matches #".*\$(.*)\@.*") last)
                    (:total-score prisoner))))
     (clojure.string/join "\n")
      println)
