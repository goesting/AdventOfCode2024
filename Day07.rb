class Integer
  def °(other)
    (self.to_s + other.to_s).to_i
  end

end

f=File.read('Day07.txt').split("\n").map{_1.split(":")}.map{|a,b| [a.to_i, b.split.map(&:to_i)]}
#part 1
p f.sum{|result, terms|
  #generate all possible arrays of + and * of the correct length
  #by taking all binary numbers up to correct length, and subbing 0's and 1's for + and *
  nr_of_ops = terms.size-1
  arr_ops = [*0...2**nr_of_ops].map{|i| i.to_s(2).rjust(nr_of_ops,'0').chars.map{|c| c==?0 ? :+ : :*}}
  #check if any of these combos work
  arr_ops.any?{|arr_ops_possibility|
    i=-1
    terms.reduce{|total,v| 
      i+=1
      [total,v].inject(arr_ops_possibility[i]) } == result } ? result : 0
}

#part 2
p f.sum{|result, terms|
#same, but with a third operator :°, which does the concat
  nr_of_ops = terms.size-1
  arr_ops = [*0...3**nr_of_ops].map{|i| i.to_s(3).rjust(nr_of_ops,'0').chars.map{|c| c==?0 ? :+ : c==?1 ? :* : :°}}
  #same but takes longer due to 3** being bigger :p
  arr_ops.any?{|arr_ops_possibility|
    i=-1
    terms.reduce{|total,v| 
      i+=1
      [total,v].inject(arr_ops_possibility[i]) } == result } ? result : 0
}
