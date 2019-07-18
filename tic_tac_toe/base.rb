class VictoryChecker
  attr_reader :squares

  def self.run(squares:, board_size:)
    params = { squares: squares, board_size: board_size }
    new(**params).check_victory
  end

  private

  def initialize(squares:, board_size:)
    @squares = squares
    @board_size = board_size
  end

  def check_victory
  end

  def is_across?
    x_coordinates = get_dimension_coordinates(:x)
    has_across = false
    board_size.times do |index|
      count = x_coordinates.count(index + 1)
      has_across = true if count == board_size
    end

    has_across
  end

  def is_down?
  end

  def is_forward_slash?
  end

  def is_back_slash?
  end

  def get_dimension_coordinates(dimension:)
    dimension_index = {
      x: 0,
      y: 1
    }[dimension]

    squares.map { |square| square[dimension_index] }
  end
end