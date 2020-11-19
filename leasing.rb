require 'date'
require 'byebug'

# This class should read input and turn it into a leasing object
class Leasing
  attr_reader :errors, :start_date, :end_date, :rent, :payment_period

  def initialize(input)
    @errors = []
    parse_leasing_arguments input
  end

  def to_s
    "leasing periods:\n#{generate_payment_period(@start_date)}"
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

  def generate_payment_period(current_date)
    result = ''
    index = 0
    while current_date < @end_date
      result += "#{index += 1}.\n" \
        "range: #{current_date} ~ #{period_end_date = calculated_period_end_date(current_date)}\n" \
        "rent: #{calculated_rent(current_date, period_end_date)}\n" \
        "payment_date: #{calculated_payment_date(current_date)}\n"
      current_date = period_end_date.next_day
    end
    result
  end

  def calculated_period_end_date(start_date)
    period_end_month_date = start_date.next_month(@payment_period - 1)
    period_end_date = Date.new(period_end_month_date.year, period_end_month_date.month, -1)

    period_end_date > @end_date ? @end_date : period_end_date
  end

  def calculated_rent(current_date, period_end_date)
    period_rent = 0
    while current_date < period_end_date
      end_of_month = Date.new(current_date.year, current_date.month, -1)
      end_of_current_month = end_of_month < period_end_date ? end_of_month : period_end_date
      period_rent += (end_of_current_month.day - current_date.day + 1) * @rent / end_of_month.day
      current_date = end_of_current_month.next_day
    end
    period_rent.to_i
  end

  def calculated_payment_date(start_date)
    default_payment_date = Date.new(start_date.prev_month.year, start_date.prev_month.month, 15)
    if (@start_date..@end_date).include? default_payment_date
      default_payment_date
    else
      @start_date
    end
  end
end

# This is a simple error class for leasing
class Error
  attr_reader :message

  def initialize(message)
    @message = message
  end
end
