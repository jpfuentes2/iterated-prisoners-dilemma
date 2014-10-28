require 'hamster/list'
require 'hamster/hash'

module Prisoner
  def prisoner(name, strategy)
    Hamster.hash(name: name, strategy: strategy, moves: Hamster.list, total: 0)
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
  def cooperate(moves); 1; end
  def defect(moves); 0; end
end

module Game
  def to_both(prisoners)
    prisoners.zip(prisoners.reverse).map do |mover, opp|
      yield mover, opp
    end
  end

  def game(prisoners)
    to_both(prisoners) do |mover, opp|
      move = mover[:strategy].(mover, opp)
      mover.put(:moves, mover[:moves].cons(move))
    end
  end

  def iterated_game(iterations, prisoners)
    (1..iterations).reduce(prisoners) do |prisoners, _|
      total_score(game(prisoners))
    end
  end

  def total_score(prisoners)
    to_both(prisoners) do |mover, opp|
      score = mover[:moves].zip(opp[:moves]).reduce(0) do |score, (m, o)|
        score += compute_score(m, o)
      end
      mover.put(:total, score)
    end
  end

  def compute_score(a, b)
    @scores ||= {
      [0, 1] => 5,
      [1, 1] => 3,
      [0, 0] => 1,
      [1, 0] => 0
    }

    @scores[[a,b]]
  end
end

[Prisoner, Moves, Strategy, Game].each { |m| include m }

prisoners = iterated_game(10, Hamster.list(
  prisoner(:a, strategy(method(:always_cooperate))),
  prisoner(:b, strategy(method(:always_defect)))
))

puts "Prisoner A (AlwaysCooperate): %d" % prisoners.head[:total]
puts "Prisoner B (AlwaysDefect)   : %d" % prisoners.last[:total]
