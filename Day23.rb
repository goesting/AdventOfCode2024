def make_graph(connections) #form input into graph
  graph = Hash.new { |hash, key| hash[key] = [] }
  connections.each{|(node1, node2)|
    graph[node1] << node2
    graph[node2] << node1
  }
  graph
end
def find_triangles(graph) #solve part1
  triangles = []
  graph.each{|node, neighbors|
    neighbors.combination(2).each{|neighbor1, neighbor2|
      if graph[neighbor1].include?(neighbor2)
        triangles << [node, neighbor1, neighbor2].sort
      end
    }
  }
  triangles.uniq
end
def largest_clique(graph) #Solve part 2, Brute force. Works on sample, but timeout on large set
  nodes = graph.keys
  largest_clique = []

  # Check if group of nodes are a clique
  def clique?(graph, nodes)
    nodes.combination(2).all? { |u, v| graph[u].include?(v) }
  end

  # Find the largest clique
  (1..nodes.size).reverse_each do |size|
    nodes.combination(size).each do |subset|
      if clique?(graph, subset)
        largest_clique = subset
        return largest_clique
      end
    end
  end

  largest_clique
end
def bron_kerbosch(r, p, x, graph, cliques) 
  if p.empty? && x.empty?
    cliques << r
  else
    pivot = (p + x).max_by { |node| graph[node].size }
    (p - graph[pivot]).each do |node|
      bron_kerbosch(r + [node], p & graph[node], x & graph[node], graph, cliques)
      p.delete(node)
      x << node
    end
  end
end

def largest_clique2(graph) #Solve part2, Maximal Clique problem, using Bron Kerbosch algorithm, thanks wikipedia
  cliques = []
  bron_kerbosch([], graph.keys, [], graph, cliques)
  cliques.max_by(&:size)
end

#Load data
connections = File.read("Day23.txt").split("\n").map{|line| line.split('-')}
graph = make_graph(connections)

#part1
connected_components = find_triangles(graph)
puts connected_components.count{|tri| tri.any?{|w| w.start_with?(?t)}}

#part2
largest_clique = largest_clique2(graph)
puts largest_clique.sort.join(",")
