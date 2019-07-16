class VictoryChecker
  attr_reader :squares

  def self.run(squares)
    new(squares).check_victory
  end

  def initialize(squares)
    @squares = squares
  end

  def check_victory
    
  end

  def is_across?
  end

  def is_down?
  end

  def is_forward_slash?
  end

  def is_back_slash?
  end
end