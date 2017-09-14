require 'pry'

class Player
  attr_reader :score, :name, :wins, :losses

  def initialize(name)
    @name = name
    @score = 0
    @wins = 0
    @losses = 0
  end

  def start_game
    @score = 0
  end

  def start_turn
    @turn_score = 0
    @turn_over = false
  end

  def record_roll(roll)
    if roll == 1
      @turn_score = 0
      @turn_over = true
    else
      @turn_score += roll
    end
  end

  def end_turn
    @score += @turn_score
  end

  def end_game
    if score >= 100
      @wins += 1
    else
      @losses += 1
    end
  end

  def roll_again?
    !@turn_over
  end
end

class CautiousPlayer < Player
  def roll_again?
    super && @turn_score < 2
  end
end

class CrazyPlayer < Player
  def roll_again?
    super && @turn_score < 20
  end
end


class OneTurnPlayer < Player
  def roll_again?
    super && @turn_score < 100
  end
end


class FiftyFiftyPlayer < Player
  def start_turn
    super
    @rollNumber = 0
  end

  def record_roll(roll)
      super
      @rollNumber += 1
  end

  def roll_again?
    !@turn_over && (rand(2) == 1) || (@rollNumber == 0)
  end
end

class TenTurnPlayer < Player
  def initialize(name)
    super
    @turnNumber = 0
  end

  def start_turn
    super
    @turnNumber += 1
  end

  def roll_again?
    if @turnNumber >= 10
      turnsLeft = 1
    else
      turnsLeft = 10 - @turnNumber
    end

    scoreNeededEachTurn = (100-@score)/turnsLeft
    # binding.pry

    if (@turn_score > scoreNeededEachTurn) || @turn_over
      return false
    else
      return true
    end

  end
end
