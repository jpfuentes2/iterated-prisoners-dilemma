package main

import (
	"fmt"
)

type Decision uint

const (
	Defect = iota
	Cooperate
)

type Prisoner struct {
	Name       string
	Decisions  []Decision
	Scores     []uint
	TotalScore uint64

	Strategy
}

type Prisoners [2]*Prisoner

type Strategy interface {
	Move(opponent *Prisoner) Decision
}

type Trial [2]Decision

var ScoreMatrix = map[Trial]uint{
	Trial{Cooperate, Defect}:    0,
	Trial{Defect, Defect}:       1,
	Trial{Cooperate, Cooperate}: 3,
	Trial{Defect, Cooperate}:    5,
}

type AlwaysDefect struct{}
type AlwaysCooperate struct{}

func (s AlwaysDefect) Move(opponent *Prisoner) Decision {
	return Defect
}

func (s AlwaysCooperate) Move(opponent *Prisoner) Decision {
	return Cooperate
}

func runGame(prisoners *Prisoners, times int) {
	toBoth := func(ps *Prisoners, fn func(mover, opp *Prisoner)) {
		fn(ps[0], ps[1])
		fn(ps[1], ps[0])
	}

	for i := 0; i < times; i++ {
		toBoth(prisoners, func(mover, opp *Prisoner) {
			mover.Decisions = append(mover.Decisions, mover.Move(opp))
		})
	}

	for i := 0; i < len(prisoners[0].Decisions); i++ {
		toBoth(prisoners, func(mover, opp *Prisoner) {
			score := ScoreMatrix[Trial{mover.Decisions[i], opp.Decisions[i]}]

			mover.Scores = append(mover.Scores, score)
			mover.TotalScore += uint64(score)
		})
	}
}

func main() {
	prisoners := &Prisoners{
		&Prisoner{Name: "a", Strategy: new(AlwaysCooperate)},
		&Prisoner{Name: "b", Strategy: new(AlwaysDefect)},
	}

	runGame(prisoners, 10)

	fmt.Println("Prisoner A (AlwaysCooperate):", prisoners[0].TotalScore)
	fmt.Println("Prisoner B (AlwaysDefect)   :", prisoners[1].TotalScore)
}
