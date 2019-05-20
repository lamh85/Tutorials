=begin

Find all the paths that go from top left to top right.
The 1s are the path.
The 0s are walls.

1 1 1 0 0
1 0 1 1 0
1 0 1 1 0
0 1 1 0 1
1 0 1 1 1

1 1 1 0 0
1 0 1 1 0
A 0 1 A 0
0 A 1 0 A
A 0 1 1 1

1 1 1 0 0
B 0 1 B 0
A 0 1 A 0
0 A 1 0 A
A 0 1 1 1

A or B = dead end OR cannot be reached

=end

@input = [
  [1, 1, 1, 0, 0],
  [1, 0, 1, 1, 0],
  [1, 0, 1, 1, 0],
  [0, 1, 1, 0, 1],
  [1, 0, 1, 1, 1],
]

@positions = []
@metadata = []

def initialize_metadata
  @positions = @input.each_with_index.map do |row, index_row|
    row.each_with_index.map do |tile, index_tile|
      {
        value: tile,
        position_x: index_tile,
        position_y: index_row
      }
    end
  end
end

def can_traverse?(tile)
  tile[:value] == 0
end

def get_tile(x:, y:)
  return unless get_tile[x]
  @input[x][y]
end

def get_neighbour_position(current_tile:, direction:)
  step_x, step_y = {
    up: [0, -1],
    right: [1, 0],
    down: [0, 1],
    left: [-1, 0]
  }[direction.to_sym]

  neighbour_x = current_tile[:position_x] + step_x
  neighbour_y = current_tile[:position_y] + step_y

  {x: neighbour_x, y: neighbour_y}
end

def get_neighbour(current_tile:, direction:)
  neighbour_position = get_neighbour_position(
    current_tile: current_tile,
    direction: direction
  )

  get_tile(neighbour_position)
end

def can_traverse?(current_tile:, direction:)
end

def add_traversal_options
  @positions.each do |row|
    row.each do |tile|
      tile_right = get_neighbour(
        tile: tile,
        direction: :right
      )
      tile_down = get_neighbour(
        tile: tile,
        direction: :down
      )
      
      can_right = tile_right && tile_right[:value] == 1
      can_down = tile_down && tile_down[:value] == 1

      puts "========"
      puts "current position:"
      puts "X: #{tile[:position_x]}, Y: #{tile[:position_y]}"
      puts "tile right:"
      puts tile_right ? tile_right : "false"
      puts "can right?"
      puts can_right ? can_right : "false"
      puts "tile down:"
      puts tile_down ? tile_down : "false"
      puts "can down?"
      puts can_down ? can_down : "false"
      # @positions[current_position_x][current_position_y][:can_right] = tile_right && tile_right[:value] == 1
      # @positions[current_position_x][current_position_y][:can_down] = tile_down && tile_down[:value] == 1
    end
  end
end