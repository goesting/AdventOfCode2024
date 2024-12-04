#INPUT
f=File.read('Day04.txt').split("\n").map &:chars
#PART1
p f.map.with_index{|line,y| line.map.with_index{|chr,x| [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]].map{|a,b|([*0..3].map{|i|(newx = x+a*i) < 0 || (newy = y+b*i) < 0 ? "OOB" : f.fetch(newy,"peepeepoopoo".chars).fetch(newx,??)}).join}.count{|w| w=="XMAS"} if chr == ?X}}.flatten.compact.sum

#PART2
p f.map.with_index{|line,y|next if (y == 0 || y == f.size-1)
  line.map.with_index{|chr,x|next if (x==0 || x==f[0].size-1)
    chr == ?A && [f.fetch(y-1).fetch(x-1),f[y+1][x+1]].sort.join == "MS" && [f[y+1][x-1],f[y-1][x+1]].sort.join == "MS"}}.flatten.compact.count{|c| c==true}
