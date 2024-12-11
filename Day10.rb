@m = File.read("Day10.txt").split("\n").map{_1.chars.map(&:to_i)}
trailheads = []

def reachablenines(x,y)
  v=@m[y][x]
  width = @m[0].size
  height = @m.size
  if v==9
    return [x,y]
  else
    res = []
    neighbours = [[1,0],[0,-1],[-1,0],[0,1]].map{|c| c.zip([x,y]).map(&:sum)}
    neighbours.select{|x,y|x>=0 && y>=0 && x<width && y<height}.each{|x,y|
      if @m[y][x] == v+1
        res += reachablenines(x,y)
      end
    }
  end
  return res.flatten.each_slice(2).to_a
end

@m.each_with_index{|line,y|line.each_with_index{|c,x|
  trailheads << [x,y] if c == 0
}}
p trailheads.map{|x,y| reachablenines(x,y).uniq.count}.sum
p trailheads.map{|x,y| reachablenines(x,y).count}.sum
