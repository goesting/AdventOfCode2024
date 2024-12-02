#INPUT
f=File.read('Day02.txt').split("\n").map{|line| line.split.map(&:to_i)}
#PART1
print "PART1 = "
puts f.count{|report|
  repDiff = report.each_cons(2).map{|a,b| a-b}
  (repDiff.all?{|x| x>0} || repDiff.all?{|x| x<0}) && repDiff.all?{|x| x.abs < 4}}.to_s
#PART2
print "PART2 = "
puts f.count{|report| ([report] + report.combination(report.size-1).to_a).any?{|comb|
    repDiff = comb.each_cons(2).map{|a,b| a-b}
    (repDiff.all?{|x| x>0} || repDiff.all?{|x| x<0}) && repDiff.all?{|x| x.abs < 4}
  }
}.to_s
