require 'matrix'
2.times{|i| p File.read("Day13.txt").delete("^0-9,\n").split("\n\n").map{|game| game.split("\n").map{|line| line.split(",").map(&:to_i)}}.sum{|a,b,prize|
    prize = prize.map{|coord| coord + 10000000000000} if i == 1 #part2
    res = Matrix[[a[0],b[0]],[a[1],b[1]]].inverse * Vector[prize[0],prize[1]]
    res.all?{_1.denominator == 1} ? res[0].to_i*3+res[1].to_i : 0
  }
}










def day13_attempt1_bruteforce
  games =  File.read("Day13.txt").delete("^0-9,\n").split("\n\n").map{|game| game.split("\n").map{|line| line.split(",").map(&:to_i)}}
  j=1
  2.times{|i|
  p games.sum{|a,b,prize|
    p "run #{j}"
    j+=1
    prize = prize.map{|coord| coord + 10000000000000} if i == 1
    bestcost = Float::INFINITY
    min_a = prize.zip(a).map{_1.reduce(:/)}.min
    min_a.downto(0){|apress|
      coords_remain = prize.zip(a.map{_1*apress}).map{_1.reduce(:-)}
      if (t=coords_remain.zip(b)).map{_1.reduce(:%)}.all?{_1==0} && t.map{_1.reduce(:/)}.uniq.size == 1
        cost = 3*apress + coords_remain[0]/b[0]
        bestcost = [bestcost,cost].min
      end
    }
    bestcost == Float::INFINITY ? 0 : bestcost
  }
  }
  end
