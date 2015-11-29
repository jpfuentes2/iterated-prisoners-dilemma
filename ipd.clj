(defn prisoner [name strategy]
  {:name name :strategy strategy})

(def score {
    [:cooperate :defect] [0 5]
    [:defect :defect] [1 1]
    [:cooperate :cooperate] [1 1]
    [:defect :cooperate] [5 0]})

(defn game
  [p1 p2]
  (let [s1 (partial (:strategy p1) p2)
        s2 (partial (:strategy p2) p1)]
    (repeatedly
     (fn []
       (score [(s1) (s2)])))))

(defn game-score
  [result]
  [(reduce + (map first result))
   (reduce + (map second result))])

(defn play-game
  [moves-count a b]
  (->> (game a b)
       (take moves-count)
       game-score))

(let [[a-score b-score] (play-game 10
                                   (prisoner "A" (constantly :cooperate))
                                   (prisoner "B" (constantly :defect)))]
  (println "Prisoner A (AlwaysCooperate):" a-score)
  (println "Prisoner B (AlwaysDefect)   :" b-score))
