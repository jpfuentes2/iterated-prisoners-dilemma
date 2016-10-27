object Main {
  sealed trait Decision extends Product with Serializable
  case object Cooperate extends Decision
  case object Defect extends Decision

  type Trial = (Decision, Decision)
  type History = List[Decision]
  type Prisoners = List[Prisoner]

  case class Prisoner(name: String,
                      strategy: Strategy,
                      history: History = List.empty,
                      totalScore: Int = 0)

  trait Strategy {
    def move(mover: History, opponent: History): History
    def cooperate(history: History) = Cooperate :: history
    def defect(history: History) = Defect :: history
  }

  case object AlwaysCooperate extends Strategy {
    def move(mover: History, opponent: History): History = cooperate(mover)
  }

  case object AlwaysDefect extends Strategy {
    def move(mover: History, opponent: History): History = defect(mover)
  }

  def score(trial: Trial): Int = trial match {
    case (Cooperate, Defect) => 0
    case (Defect, Defect) => 1
    case (Cooperate, Cooperate) => 3
    case (Defect, Cooperate) => 5
  }

  def game(prisoners: Prisoners) = {
    prisoners.zip(prisoners.reverse).map { case (mover, opponent) =>
      val strategy = mover.strategy
      mover.copy(history = strategy.move(mover.history, opponent.history))
    }
  }

  def iteratedGame(iterations: Int, prisoners: Prisoners): Prisoners = {
    1.to(iterations).foldLeft(prisoners){ (prisoners, _) => game(prisoners) }
  }

  def totalScores(prisoners: Prisoners): Prisoners = {
    prisoners.zip(prisoners.reverse).map { case (mover, opponent) =>
      val totalScore = mover.history.zip(opponent.history).foldLeft(0) { case (total, (m, o)) =>
        total + score((m, o))
      }
      mover.copy(totalScore = totalScore)
    }
  }

  def main(args: Array[String]): Unit = {
    val prisoners = List(Prisoner("a", AlwaysCooperate), Prisoner("b", AlwaysDefect))

    totalScores(iteratedGame(10, prisoners)).foreach { p =>
      println(s"Prisoner ${p.name.toUpperCase} (${p.strategy}): ${p.totalScore}")
    }
  }
}
