antinodes = []
nodes = {}
inp = File.read("Day08.txt").split("\n").map(&:chars)
width = inp[0].size
height = inp.size

inp.each_with_index{|line,y| line.each_with_index{|c,x|
  if c!='.'
    nodes[c] ||= []
    nodes[c] << [y,x]
  end
}}

nodes.each{|k,v|
  v.combination(2){|a,b|
    ydiff = b[0]-a[0]
    xdiff = b[1]-a[1]
    a2x = a[1]-xdiff
    a2y = a[0]-ydiff
    b2x = b[1]+xdiff
    b2y = b[0]+ydiff
    antinodes << [a2y,a2x] unless a2y < 0 ||  a2x < 0 || a2y >= height || a2x >= width
    antinodes << [b2y,b2x] unless b2y < 0 ||  b2x < 0 || b2y >= height || b2x >= width
  }
}
p antinodes.uniq.size

#Part2
antinodes2=[]
nodes.each{|k,v|
  v.combination(2){|a,b|
    ydiff = b[0]-a[0]
    xdiff = b[1]-a[1]

    x=b[1]
    y=b[0]
    until (x<0 || x>= width || y<0 || y>= height) do #go a->b
      antinodes2 << [y,x]
      x-=xdiff
      y-=ydiff
    end

    x=a[1]
    y=a[0]
    until (x<0 || x>= width || y<0 || y>= height) do #go b->a
      antinodes2 << [y,x]
      x+=xdiff
      y+=ydiff
    end
  }
}
p antinodes2.uniq.count
