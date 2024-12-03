#INPUT
f=File.read('Day03.txt')
#PART1
puts f.scan(/mul\(\d{1,3},\d{1,3}\)/).sum{|l| l.delete("^0-9,").split(",").map(&:to_i).inject(:*)}
#PART2
puts f.scan(/(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/).map(&:compact).flatten.slice_before{|t| t[0]==?d}.reject{|line| line[0] == "don't()"}.flatten.map{|l| l.delete("^0-9,").split(",").map(&:to_i).inject(:*)}.compact.sum
