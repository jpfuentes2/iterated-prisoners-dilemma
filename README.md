# Iterated Prisoners Dilemma

This is my attempt at implementing the [IPD](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma#The_iterated_prisoners.27_dilemma) algorithim in multiple languages. Originally, I chose Ruby, Go, Scala, Clojure, and Haskell as target languages. Each implementation is either functional in nature or with low ceremony.

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

-- PHP --
JUST KIDDING!!
```

### Dependencies

* PHP: roll the dice!
* Ruby: >= 2.0
* Haskell: roll the dice!
* Scala: roll the dice!
* Clojure: lein with `lein-exec` should do it

## Thanks

Special thanks to [@joxn](https://github.com/joxn) for improving the
Haskell version. You can see my initial pathetic attempt [here](https://gist.github.com/jpfuentes2/9317779#file-ipd-hs).
