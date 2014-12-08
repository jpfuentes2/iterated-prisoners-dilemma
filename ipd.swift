enum DecisionType {
	case Defect
	case Cooperate
}

protocol Strategy {
	func move(opponent: Prisoner) -> DecisionType
}

struct AlwaysDefect : Strategy {
	func move(opponent: Prisoner) -> DecisionType {
		return DecisionType.Defect
	}
}

struct AlwaysCooperate : Strategy {
	func move(opponent: Prisoner) -> DecisionType {
		return DecisionType.Cooperate
	}
}

struct Trial {
	subscript(mover: DecisionType, opp: DecisionType) -> Int {
		get {
			switch (mover, opp) {
			case (.Cooperate, .Defect):
				return 0
			case (.Defect, .Defect):
				return 1
			case (.Cooperate, .Cooperate):
				return 3
			case (.Defect, .Cooperate):
				return 5
			}
		}
	}
}

class Prisoner : Strategy {
	let name: String
	let strategy: Strategy
	var scores: [Int] = []
	var decisions: [DecisionType] = []
	var totalScore: Int = 0
	
	init(_ name: String, _ strategy: Strategy) {
		self.name = name
		self.strategy = strategy
	}
	
	func move(mover: Prisoner) -> DecisionType {
		return strategy.move(mover)
	}
}

func runGame(ps: [Prisoner], times: Int) -> () -> (String, String) {
	return { results in
		func swap(ps: [Prisoner], fn: (mover: Prisoner, opp: Prisoner) -> ()) {
			fn(mover: ps[0], opp: ps[1])
			fn(mover: ps[1], opp: ps[0])
		}
		
		for i in 0..<times {
			swap(ps) { (mover: Prisoner, opp: Prisoner) in
				mover.decisions.append(mover.move(opp))
			}
			
			swap(ps) { (mover: Prisoner, opp: Prisoner) in
				let score = Trial()[mover.decisions[i], opp.decisions[i]]
				mover.scores.append(score)
				mover.totalScore += score
			}
		}
		
		return ("Prisoner A (AlwaysCooperate): \(prisoners[0].totalScore)", "Prisoner B (AlwaysDefect): \(prisoners[1].totalScore)")
	}
}

let prisoners: [Prisoner] = [Prisoner("a", AlwaysCooperate()), Prisoner("b", AlwaysDefect())]
let (PrisonerA, PrisonerB) = runGame(prisoners, 10)()
println(PrisonerA)
println(PrisonerB)
