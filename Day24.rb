










bit_values, logicgates = File.read("Day24.txt").split("\n\n")
bit_values = bit_values.split("\n").map{|line| [line.split(': ')[0],line.split(': ')[1].to_i]}.to_h
p bit_values

logicgates = logicgates.split("\n").map{|line|
pre,post = line.split(" -> ")  
var1,op,var2 = pre.split
op = case op
  when "XOR"
    :^
  when "OR"
    :|
  when "AND"
    :&
  else
    puts "Panic!"
end
{:var1 => var1,:var2 =>var2,:op => op,:res => post}
}
change = true
while change
  change = false
  logicgates.each{|operation|
    if !bit_values.key?(operation[:res]) && bit_values.key?(operation[:var1]) && bit_values.key?(operation[:var2])
      bit_values[operation[:res]] = [bit_values[operation[:var1]],bit_values[operation[:var2]]].inject(operation[:op])
      change = true
    end
  }
end

p bit_values.select{|k,v| k.start_with?(?z)}.sort.map{|k,v| v}.reverse.join.to_i(2)
logicgates.sort_by{_1[:var1]}.each{p _1}
