import Data.Tuple( swap )
import Data.List( foldl' )

data Decision = Cooperate | Defect
  deriving (Show)

type Trial = (Decision, Decision)

type Score = (Integer, Integer)

type History = [Trial]

type Strategy = History -> Decision

sumScore :: Score -> Score -> Score
(a1, a2) `sumScore` (b1, b2) = (a1 + b1, a2 + b2)

score :: Trial -> Score
score (Cooperate, Defect)    = (0, 5)
score (Defect, Defect)       = (1, 1)
score (Cooperate, Cooperate) = (3, 3)
score (Defect, Cooperate)    = (5, 0)

scoreGame :: History -> Score
scoreGame = foldl' sumScore (0, 0) . map score

runGame :: History -> Strategy -> Strategy -> History
runGame hist s1 s2 = moves : runGame (moves : hist) s1 s2
  where
    moves = (s1 hist, s2 $ map swap hist)

play :: Int -> Strategy -> Strategy -> History
play iters s1 s2 = take iters $ runGame [] s1 s2

main = do
  putStrLn $ "Prisoner A (AlwaysCooperate): " ++ show (fst scores)
  putStrLn $ "Prisoner B (AlwaysDefect)   : " ++ show (snd scores)
  where
    scores = scoreGame $ play 10 (const Cooperate) (const Defect)
