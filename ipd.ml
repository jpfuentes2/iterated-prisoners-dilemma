type decision = Cooperate | Defect

let swap (a, b) = b, a

let score = function
  | Cooperate, Defect    -> 0, 5
  | Defect,    Defect    -> 1, 1
  | Cooperate, Cooperate -> 3, 3
  | Defect,    Cooperate -> 5, 0

let sum_score (a1, a2) (b1, b2) = (a1 + b1, a2 + b2)

let score_game game = game
  |> List.map score
  |> List.fold_left sum_score (0, 0)

let rec run_game hist s1 s2 = function
  | 0 -> []
  | iters ->
     let moves = (s1 hist, s2 @@ List.map swap hist) in
     moves :: run_game (moves :: hist) s1 s2 (iters - 1)

let play iters s1 s2 = run_game [] s1 s2 iters

let () =
  let always_coop   = fun _ -> Cooperate in
  let always_defect = fun _ -> Defect in
  let results = play 10 always_coop always_defect in
  let coop_scores, defect_scores = score_game results in
  Printf.printf "Prisoner A (AlwaysCooperate): %d\n" coop_scores;
  Printf.printf "Prisoner B (AlwaysDefect)   : %d\n" defect_scores
