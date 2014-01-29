require 'time'

file_name = ARGV[0]
rows = File.read(file_name).split("\n")

# example: 2014-01-29 16:13:48 +0100: 0.584045
matches = rows.map do |row| 
  row.scan(/INFO -- : (.+) \+0100: ([0-9\.]+)/).first
end

matches.each do |match|
  time = Time.parse(match[0]).strftime('%H:%M:%S')
  duration = match[1].to_s.gsub('.', ',')
  puts "#{time};#{duration}"
end