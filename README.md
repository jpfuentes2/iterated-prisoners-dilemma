# Iterated Prisoners Dilemma

This is my attempt at implementing the [IPD](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma#The_iterated_prisoners.27_dilemma) algorithim in multiple languages. Originally, I chose Ruby, Go, Scala, Clojure, and Haskell as target languages. Each implementation is either functional in nature or with low ceremony.

Presently, only two strategies are available in each of the languages: `AlwaysCooperate` and `AlwaysDefect` which do what you'd expect: *constantly* move respective of the name. Thus, the winner from 10 iterations is `AlwaysDefect` and the score should be 50 to 0. Some day I may improve on the examples by adding new and more challenging strategies.

My *hope* is that contributors and/or I will add more languages!

> The iterated prisoners' dilemma game is fundamental to certain theories of human cooperation and trust. On the assumption that the game can model transactions between two people requiring trust, cooperative behaviour in populations may be modeled by a multi-player, iterated, version of the game. It has, consequently, fascinated many scholars over the years. In 1975, Grofman and Pool estimated the count of scholarly articles devoted to it at over 2,000. The iterated prisoners' dilemma has also been referred to as the "Peace-War game".[8]
- [Wikipedia](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma#The_iterated_prisoners.27_dilemma)

## Why?

Implementing the same non-trivial algorithm in various languages has
improved my proficiency not only in *these* languages, but, also my general
programming competency.

How so? I like to think it's because I have employed many of the
techniques argued in ["Make It Stick: The Science of Successful Learning"](http://www.amazon.com/Make-It-Stick-Successful-Learning/dp/0674729013).
Specifically:

* Embraced difficulties: Writing what I consider to be elegant code in
  each language stretched my mental faculties.
* Retrieval: Simply put: *writing the implementation* of IPD for a given
  language is exercising retrieval.
* Spacing & Interleaving: I did each of the examples over a few months
  and built on initial versions to gradually improve each language's
  implementation.

Also, because it's *fun* and that's a good enough reason.

## Usage

```bash
λ ./test.sh
-- Go --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect)   : 50

-- Ruby --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect)   : 50

-- Haskell --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect)   : 50

-- Clojure --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect): 50

-- Scala --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect): 50

-- OCaml --
Prisoner A (AlwaysCooperate): 0
Prisoner B (AlwaysDefect):    50

-- PHP --
JUST KIDDING!!
```

## Languages

Languages currently implemented and the contributor:

* Haskell: @jpfuentes2
* Scala: @jpfuentes2
* Ruby: @jpfuentes2
* Clojure: @jpfuentes2
* Go: @jpfuentes2
* PHP: @jpfuentes2
* OCaml: @tizoc

### Dependencies

* PHP: roll the dice!
* Ruby: >= 2.0
* Haskell: roll the dice!
* Scala: roll the dice!
* Clojure: lein with `lein-exec` should do it
* OCaml: roll the dice!

### Notes

#### Go
* Less functional than most examples given I'm using pointers and constantly mutating the prisoner struct fields. This is closer to the Gopher way.
* Decision type is a uint because Go has no ADTs and limited polymorphism
* No ADTs means I cannot enforce strategy functions to return a Decision type which means I cannot eliminate invalid states in this program if new users created new strategies. Of course, I could use interface{} + type assertions and check invariants at run-time, but that would be verbose. This singular piece of code highlights the simplicity of Go's type system.
* Pattern matching for the score matrix would be nice.

#### Clojure
* Like Go, it uses a uint for defect/cooperate values rather than types since we're in a dynamic language.
* Thrush/threading/pipe macros are the reader's friend.
* The more I use statically typed languages the more I find a preference for them but working in Clojure is very pleasing.
* I'd love to get feedback from people who've never done Lisp/Clojure/Dynamically typed languages -- can you follow the code?

#### Scala
* Defining ADTs is about as verbose as common Go
* I could drop many of the type annotations but probably not all due to limited type inference. Some Scala pros recommend writing most annotations esp. for public APIs.
* I think the use of traits + case objects make sense for defining the strategy implementations. Any thoughts here?
* Scala's type alias (for History or List[A]) is annoying because we don't have access to the alias'd companion object -- notice I have to write History.empty even though List.empty exists

### Contributors

A big thank you to these contributors:

* @tizoc

Also, thanks to [@joxn](https://github.com/joxn) for improving the
Haskell version. You can see my initial pathetic attempt [here](https://gist.github.com/jpfuentes2/9317779#file-ipd-hs).
