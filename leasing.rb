require 'date'

# This class should read input and turn it into a leasing object
class Leasing
  attr_reader :errors, :start_date, :end_date, :rent, :payment_period

  def initialize(input)
    @errors = []
    parse_leasing_arguments input
  end

  private

  def parse_leasing_arguments(input)
    input_arr = input.split(',')
    @errors << Error.new('Argument number not correct.') if input_arr.length != 4

    @start_date = parse_date_argument(input_arr[0], 'Start date')
    @end_date = parse_date_argument(input_arr[1], 'End date')

    @errors << Error.new('Start date should be smaller than end_date.') if @start_date > @end_date

    @rent = input_arr[2]&.to_f
    @payment_period = input_arr[3]&.to_i
  end

  def parse_date_argument(date, variable_name)
    Date.parse(date)
  rescue ArgumentError, TypeError
    @errors << Error.new("#{variable_name} is not valid.")
    Date.new(2020)
  end
end

# This is a simple error class for leasing
class Error
  attr_reader :message

  def initialize(message)
    @message = message
  end
end
