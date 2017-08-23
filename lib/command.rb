class Command
  PLACE_TYPE    = 'PLACE'.freeze
  MOVE_TYPE     = 'MOVE'.freeze
  LEFT_TYPE     = 'LEFT'.freeze
  RIGHT_TYPE    = 'RIGHT'.freeze
  REPORT_TYPE   = 'REPORT'.freeze
  
  AVAILABLE_TYPES        = [PLACE_TYPE, MOVE_TYPE, LEFT_TYPE, RIGHT_TYPE, REPORT_TYPE]
  AVAILABLE_TYPES_REGEXP = Regexp.new('^(' + AVAILABLE_TYPES.join('|') + ')')
  
  def initialize(command_string)
    self.command_string = command_string
  end

  def valid?
    # Lets assume for now that the only requirement 
    # for command is to start from one of the AVAILABLE_TYPES

    command_string.match(AVAILABLE_TYPES_REGEXP)
  end
  
  def place?
    command_string =~ Regexp.new("^#{PLACE_TYPE}")
  end

  def get_position_x
    raise 'Wrong Command Type' unless place?
    
    command_string.scan(/\d+{1,}/).first
  end

  def get_position_y
    raise 'Wrong Command Type' unless place?
    
    command_string.scan(/\d+{1,}/).last
  end

  def get_facing
    raise 'Wrong Command Type' unless place?

    command_string.scan(/[A-Z]{1,}$/).last
  end
  
  def move?
    command_string =~ Regexp.new("^#{MOVE_TYPE}")
  end

  def left?
    command_string =~ Regexp.new("^#{LEFT_TYPE}")
  end

  def right?
    command_string =~ Regexp.new("^#{RIGHT_TYPE}")
  end

  def report?
    command_string =~ Regexp.new("^#{REPORT_TYPE}")
  end

  private
  attr_accessor :command_string
end
