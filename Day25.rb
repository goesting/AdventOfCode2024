locks,keys = File.read("Day25.txt").split("\n\n").map{|lock| lock.split("\n").map(&:chars).transpose}.group_by{|x| x[0][0]}.values
depth = locks[0][0].size
locks = locks.map{|lock|lock.map{|line| line.count('#')}}
keys = keys.map{|lock|lock.map{|line| line.count('#')}}

p locks.map{|lock| keys.map{|key| key.zip(lock).map{_1.inject(:+)}.all?{|x| x<=depth}}}.flatten.count(true)
