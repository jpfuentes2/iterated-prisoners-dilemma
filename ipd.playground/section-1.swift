//
//  main.swift
//  Iterated Prisoners Dilemma
//
//  Created by Andre Dublin on 11/16/14.
//  Copyright (c) 2014 Andre Dublin. All rights reserved.

import Foundation

enum DecisionType: Int {
	case Defect = 0
	case Cooperate = 1
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
	let mover: Int, opp: Int
	
	/*
	 * Subscript are shortcuts for accessing the member elements of a collection, list, or sequence
	 * More @ https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html
	 */
	subscript() -> Int {
		get {
			switch (mover, opp) {
			case (DecisionType.Cooperate.rawValue, DecisionType.Defect.rawValue):
				return 0
			case (DecisionType.Defect.rawValue, DecisionType.Defect.rawValue):
				return 1
			case (DecisionType.Cooperate.rawValue, DecisionType.Cooperate.rawValue):
				return 3
			case (DecisionType.Defect.rawValue, DecisionType.Cooperate.rawValue):
				return 5
			default:
				return 0
			}
		}
	}
}

class Prisoner : Strategy {
	var name: String
	var strategy: Strategy
	var scores: [Int] = []
	var decisions: [Int] = []
	var totalScore: Int = 0
	
	init(name: String, strategy: Strategy) {
		self.name = name
		self.strategy = strategy
	}
	
	func move(mover: Prisoner) -> DecisionType {
		return strategy.move(mover)
	}
}

func runGame(prisoners: [Prisoner], times: Int) {
	/*
	 * Nested function that takes a function as a paramter.
	 * For void return types you have to include the "-> ()" syntax.
	 * Unlike global or nested functions with void return types that do not require it.
	 */
	func toBoth(ps: [Prisoner], fn: (mover: Prisoner, opp: Prisoner) -> ()) {
		fn(mover: ps[0], opp: ps[1])
		fn(mover: ps[1], opp: ps[0])
	}
	
	/*
	 * Inclusive for in loop (i in 0...Array)
	 */
	for i in 0...times {
		/*
		 * Closure Syntax
		 * { (paramters) -> return type in statements }
		 * More @ https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
		 */
		toBoth(prisoners, { (mover: Prisoner, opp: Prisoner) in
			mover.decisions.append(mover.move(opp).rawValue)
		})
	}
	
	/*
	 * Exclusive for in loop (i in 0..<Array)
	 */
	for i in 0..<prisoners[0].decisions.count {
		toBoth(prisoners, { (mover: Prisoner, opp: Prisoner) in
			let score = Trial(mover: mover.decisions[i], opp: opp.decisions[i])[]
			mover.scores.append(score)
			mover.totalScore += score
		})
	}
}

func main() {
	let prisoners: [Prisoner] = [
		Prisoner(name: "a", strategy: AlwaysCooperate()),
		Prisoner(name: "b", strategy: AlwaysDefect())
	]
	
	runGame(prisoners, 10)
	
	println("Prisoner A (Always Cooperate): \(prisoners[0].totalScore)")
	println("Prisoner B (Always Defect): \(prisoners[1].totalScore)")
}

main()