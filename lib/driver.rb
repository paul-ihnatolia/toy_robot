require_relative "toy_robot"
require_relative "command"

class Driver
  def initialize(input_file_name, output_file_name, x_dimension_limit, y_dimension_limit)
    self.input_file_name = input_file_name
    self.output_file_name = output_file_name
    self.toy_robot = ToyRobot.new(x_dimension_limit, y_dimension_limit)
  end

  def run
    commands_block.each do |el|
      current_command = Command.new(el)

      if current_command.valid?
        if current_command.place?
          toy_robot.set_positions(current_command.get_position_x.to_i, current_command.get_position_y.to_i)
          toy_robot.set_facing(current_command.get_facing)
          toy_robot.activate!
        elsif current_command.move? && toy_robot.activated?
          toy_robot.move
        elsif current_command.left? && toy_robot.activated?
          toy_robot.rotate_left
        elsif current_command.right? && toy_robot.activated?
          toy_robot.rotate_right
        elsif current_command.report? && toy_robot.activated?
          print_current_coordinates
        end
      end
    end
  end

  private
  attr_accessor :input_file_name, :output_file_name, :toy_robot
  
  def print_current_coordinates
    File.write(output_file_name, toy_robot.get_printable)
  end

  def commands_block
    @commands_block ||= File.readlines(input_file_name).map(&:strip)
  end
end
