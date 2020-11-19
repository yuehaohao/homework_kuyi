require './leasing'

leasing = Leasing.new(ARGV[0] || '')

if leasing.errors.length.positive?
  leasing.errors.each do |error|
    puts error.message
  end
else
  puts leasing.to_s
end
