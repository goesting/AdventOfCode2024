
f= File.read("Day14.txt").delete("pv=").split("\n").map{|line| line.split(" ").map{|el| el.split(",").map(&:to_i)}}
WIDTH = 101
HEIGHT = 103
MAXTIME = 10000 #set to 100 for part1

MAXTIME.times{|loopnr| f.map!{|position,velocity|[[(position[0]+velocity[0])%WIDTH,(position[1]+velocity[1])%HEIGHT],velocity]}
  arr=Array.new(HEIGHT){Array.new(WIDTH,'-')}
  f.each{|pos,vel| arr[pos[1]][pos[0]] = 'X'}
  if arr.any?{|line| /XXXXXXX/ === line.join}
    arr.each{|line| puts line.join} #manually check the picture for christmas tree
    xxxx=gets                       #ask user input to continue
  end
  p loopnr
}

p f.group_by{|pos,vel| [(WIDTH/2-pos[0])<=>0,(HEIGHT/2-pos[1])<=>0]}.map{|k,v| k.all?{_1!=0} ? v.size : 1 }.inject(:*)

