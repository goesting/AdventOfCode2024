@designs_buff = {}

def isPossible?(design,towels)
  return true if design == ""
  f=towels.any?{|t| design.start_with?(t) && isPossible?(design[t.size..],towels) }
end
def isPossible2?(design,towels)
  return 1 if design == ""
  return @designs_buff[design] if @designs_buff.key? design
  f=towels.sum{|t| design.start_with?(t) ? isPossible2?(design[t.size..],towels) : 0 }
  @designs_buff[design] = f
  return f
end

towels,designs = File.read("Day19.txt").split("\n\n")

towels = towels.split(", ")
designs = designs.split
p designs.count{|design| isPossible?(design,towels)}
p designs.sum{|design| isPossible2?(design,towels)}
