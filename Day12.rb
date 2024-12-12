@grid = File.read("Day12.txt").split("\n").map{|l|l.chars}
@visited = Array.new(@grid.size){Array.new(@grid[0].size,false)}
@neighbours = [[1,0],[0,1],[-1,0],[0,-1]]
def getDimensions(y,x,char)
  return [0,0] if x < 0 || y < 0 || y >= @grid.length || x >= @grid[0].length
  return [0,0] if @visited[y][x] || @grid[y][x] != char
  
  @visited[y][x] = true
  area = 1
  peri = 4
  @neighbours.each{|a,b|
    area2 = peri2 = 0
    area2,peri2 = getDimensions(y+a,x+b,char) unless x+b < 0 || y+a < 0 || y+a >= @grid.length || x+b >= @grid[0].length
    p "#{a},#{b}",@neighbours.map{|i,j| [y+i>0,x+j>0,y+i<@visited.size,x+j<@visited[0].size]}
    area+=area2
    peri+=peri2 #- (4-2*neighbours.count{|a,b|y+a>0 && x+b>0 && y+a<@visited.size && x+b<@visited[0].size})unless peri2 == 0
    warn "area for part #{char} is now #{area}, and peri is #{peri}"
  }
  return [area,peri]
end

total_a = {}
total_p = {}
@grid.each_with_index{|line,y| 

  line.each_with_index{|plot,x|
    p "Main loop at y #{y} and x #{x}, showing value #{plot}. Visited? = #{@visited[y][x]}"
    area,perimeter = getDimensions(y,x,plot)
    total_a[plot]||=0
    total_a[plot] += area
    total_p[plot]||=0
    total_p[plot] += perimeter
}}
p total_a, total_p
p total_a.map{|k,v| v*total_p[k]}
