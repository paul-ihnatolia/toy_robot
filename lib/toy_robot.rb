class ToyRobot
  NORTH_FACING  = 'NORTH'.freeze
  EAST_FACING   = 'EAST'.freeze
  SOUTH_FACING  = 'SOUTH'.freeze
  WEST_FACING   = 'WEST'.freeze
  
  FACINGS = [NORTH_FACING, EAST_FACING, SOUTH_FACING, WEST_FACING]
  
  def initialize(x_dimension_limit, y_dimension_limit)
    self.x_dimension_limit  = x_dimension_limit
    self.y_dimension_limit  = y_dimension_limit
    self.activated          = false
  end

  def activated?
    activated
  end

  def activate!
    self.activated = true
  end

  def set_positions(position_x, position_y)
    if check_x_position(position_x) && check_y_position(position_y)
      self.position_x = position_x
      self.position_y = position_y
    else
      raise ArgumentError, 'Position X or Position Y are out of the range'
    end
  end
  
  def set_facing(facing)
    self.facing = facing
  end
  
  def get_printable
    "#{position_x},#{position_y},#{facing}"
  end

  def move
    case facing
      when WEST_FACING
        move_west
      when NORTH_FACING
        move_north
      when EAST_FACING
        move_east
      when SOUTH_FACING
        move_south
    end
  end
  
  def rotate_right
    self.facing = FACINGS[(FACINGS.index(facing) + 1) % FACINGS.length]
  end
  
  def rotate_left
    self.facing = FACINGS[(FACINGS.index(facing) - 1) % FACINGS.length]
  end
  
  private
  attr_accessor :position_x, :position_y, :facing,
                :activated, :x_dimension_limit, :y_dimension_limit

  def move_west
    new_position_x = position_x - 1
    if check_x_position(new_position_x)
      self.position_x = new_position_x
    end
  end

  def move_north
    new_position_y = position_y + 1
    if check_y_position(new_position_y)
      self.position_y = new_position_y
    end
  end

  def move_east
    new_position_x = position_x + 1
    if check_x_position(new_position_x)
      self.position_x = new_position_x
    end
  end

  def move_south
    new_position_y = position_y - 1
    if check_y_position(new_position_y)
      self.position_y = new_position_y
    end
  end

  def check_x_position(x)
    x >= 0 && x < x_dimension_limit
  end

  def check_y_position(y)
    y >= 0 && y < y_dimension_limit
  end
end
