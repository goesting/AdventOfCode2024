stones={}
stones_nextstate = {}
File.read("Day11.txt").split.map(&:to_i).each{|i| stones[i]||=0;stones[i]+=1}
REPEATS=75 #Set to 25 for part 1

REPEATS.times{
  stones.each{|nr,amt|
    if nr == 0
      stones_nextstate[1]||=0
      stones_nextstate[1] += amt
    elsif nr.digits.size % 2 == 0
      a,b = nr.to_s[...nr.to_s.size/2].to_i,nr.to_s[nr.to_s.size/2..].to_i
      stones_nextstate[a]||=0
      stones_nextstate[b]||=0
      stones_nextstate[a]+=amt
      stones_nextstate[b]+=amt
    else
      stones_nextstate[nr*2024]||=0
      stones_nextstate[nr*2024]+=amt
    end
  }
  
  stones=stones_nextstate
  stones_nextstate = {}
}
p stones.values.sum
