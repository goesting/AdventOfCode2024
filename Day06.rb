def do_i_loop?(map, x,y,facing)
  width = map[0].size
  height = map.size
  direction = {'N' => [0,-1], 'E' => [1,0], 'S' => [0,1], 'W' => [-1,0]}
  visited = {}  #all visited locations, contains list of wind directions when passing through
  while x*y > 0 && x < width && y < height
    visited[x+y*width] ||= []     #Make sure dict entry in visited exists
    if visited[x+y*width].include?(facing)
      return true
    end
    visited[x+y*width] << facing
    xnext,ynext = [x,y].zip(direction[facing]).map(&:sum)
    while map.fetch(ynext,[?.]).fetch(xnext,'.') == '#'
      facing = {'N'=>'E','E'=>'S','S'=>'W','W'=>'N'}[facing]
      xnext,ynext = [x,y].zip(direction[facing]).map(&:sum)
    end
    x,y=xnext,ynext #if free, set as new location
  end
  return false
end
#INPUT
map=File.read('Day06.txt').split("\n").map(&:chars)
width = map[0].size
height = map.size
#Setup
x=y=-1
map.each_with_index do |line, i|
  line.each_with_index do |element, j|
    y,x = [i, j] if element == '^'
  end
end
x_orig = x
y_orig = y
direction = {'N' => [0,-1], 'E' => [1,0], 'S' => [0,1], 'W' => [-1,0]}
facing = 'N'  #currently facing
visited = {}  #all visited locations, contains list of wind directions when passing through
blockers = [] #collect all possible block locations

#Akshual work
while x*y > 0 && x < width && y< height #&& test !=0
  visited[x+y*width] ||= []     #Make sure dict entry in visited exists
  xnext,ynext = [x,y].zip(direction[facing]).map(&:sum)
  visited[x+y*width] << facing
  #check new position in front, if blocked, rotate to the right
  while map.fetch(ynext,[?.]).fetch(xnext,'.') == '#'
    facing = {'N'=>'E','E'=>'S','S'=>'W','W'=>'N'}[facing]
    xnext,ynext = [x,y].zip(direction[facing]).map(&:sum)
  end
  blockers << [xnext,ynext] if do_i_loop?(map.map.with_index{|line,i| line.map.with_index{|c,j| i==ynext && j==xnext ? '#' : c}},x_orig,y_orig,'N')
  x,y=xnext,ynext
end


#-=-OUTPUT-=-
puts visited.size
#p visited
p blockers.uniq.size
p blockers
#PART2
