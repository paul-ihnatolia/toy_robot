require_relative 'lib/driver'

X_DIMENSION_LIMIT = 5
Y_DIMENSION_LIMIT = 5

input_file_name = ARGV[0]
output_file_name = ARGV[1]

Driver.new(input_file_name, output_file_name, X_DIMENSION_LIMIT, Y_DIMENSION_LIMIT).run
