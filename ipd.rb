require 'hamster/list'
require 'hamster/hash'

def list; Hamster.list; end

module Prisoner
  def prisoner(name, strategy, moves = Hamster.list, scores = Hamster.list)
    Hamster.hash(name: name, strategy: strategy, moves: moves, scores: scores)
  end
end

module Strategy
  def strategy(strategy)
    -> mover, other { strategy.(mover[:moves], other[:moves]) }
  end

  def always_cooperate(mover, other); cooperate(mover); end

  def always_defect(mover, other); defect(mover); end
end

module Moves
  def cooperate(moves); moves.cons(1); end
  def defect(moves); moves.cons(0); end
end

module Game
  def game(a, z)
    moves_a = a[:strategy].(a, z)
    moves_z = z[:strategy].(z, a)

    Hamster.list(
      a.put(:moves, moves_a),
      z.put(:moves, moves_z)
    )
  end

  def iterated_game(iterations, a, z)
    (1..iterations).reduce(Hamster.list(a,z)) do |prisoners, _|
      game(prisoners.head, prisoners.last)
    end
  end

  def score(a, z)
    a.zip(z).reduce(Hamster.hash(a: list, z: list)) do |scores, (move_a, move_z)|
      score_a = compute_score(move_a, move_z)
      score_z = compute_score(move_z, move_a)

      Hamster.hash(
        a: scores[:a].cons(score_a),
        z: scores[:z].cons(score_z)
      )
    end
  end

  def compute_score(a, z)
    @scores ||= {
      [0, 1] => 5,
      [1, 1] => 3,
      [0, 0] => 1,
      [1, 0] => 0
    }

    @scores[[a,z]]
  end
end

[Prisoner, Moves, Strategy, Game].each { |m| include m }

a = prisoner(:a, strategy(method(:always_cooperate)))
z = prisoner(:z, strategy(method(:always_defect)))

a, z = iterated_game(10, a, z)
scores = score(a[:moves], z[:moves])

puts "Prisoner A (AlwaysCooperate): %d" % scores[:a].sum
puts "Prisoner B (AlwaysDefect)   : %d" % scores[:z].sum
