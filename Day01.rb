#Part1
puts File.open('day01.txt').read.split("\n").map{|line| line.split.map(&:to_i)}.transpose.map(&:sort).transpose.sum{|a,b| (a-b).abs }

#Part2
left,right=File.open('day01.txt').read.split("\n").map{|line| line.split.map(&:to_i)}.transpose
right=right.tally
puts left.sum{|i| i*right.fetch(i,0)}
