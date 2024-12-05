require 'tsort'
class InequalityGraph
  include TSort
  def initialize
    @graph = {}
  end
  def add_inequality(smol, grande)
    @graph[smol] ||= []
    @graph[smol] << grande
    @graph[grande] ||= []
  end
  def tsort_each_node(&block)
    @graph.each_key(&block)
  end
  def tsort_each_child(node, &block)
    @graph[node].each(&block)
  end
end

#INPUT
rules_in,books=File.read('Day05.txt').split("\n\n")
rules_in = rules_in.split("\n").map{|line| line.split("|").map(&:to_i)}
books=books.split("\n").map{|line| line.split(",").map(&:to_i)}
rules = {}
rules_in.each{|a,b| rules[a] = rules.fetch(a,[]) + [b]}

#PART1
p books.sum{|book| rules.all?{|k,v|!book.include?(k) || v.all?{|x| !book.include?(x) || book.index(x) > book.index(k) } } ? book[book.size/2] : 0}

#PART2
p books.sum{|book|
  #prep the topological sort
  ranked = InequalityGraph.new
  rules_in.each{|a,b|ranked.add_inequality(a,b) if book.include?(a) && book.include?(b)}
  ranked_sorted = ranked.tsort
  #calculate
  book.sort_by{|i| -ranked_sorted.index(i)} == book ? 0 : book.sort_by{|i| ranked_sorted.index(i)}[book.size/2]
}
