#INIT
secrets = File.read("Day22.txt").split.map &:to_i
LOOPS = 2000
MODOP = 16777216
part2=[]
results = {}
comboalreadyseen = {}

#PART1
LOOPS.times{|i|
  part2 << secrets.map{|x| x.digits[0]}
  secrets.map!{|x| x=(x ^ x<<6)%MODOP
                   x=(x ^ x>>5)%MODOP
                   x=(x ^ x<<11)%MODOP}
}
part2 << secrets.map{|x| x.digits[0]}
p secrets.sum

#PART2
part2 = part2.transpose.map{|line| line.each_cons(5).map{|a,b,c,d,e| [[b-a,c-b,d-c,e-d],e]}.to_a}
part2.each{|differences| differences.each{|dt|
  diff,target = dt
  if !comboalreadyseen.key? diff
    results[diff] ||= 0
    results[diff] += target
    comboalreadyseen[diff] = true
  end
}
comboalreadyseen = {}
}

p results.max_by{|k,v|v}
