arr,res,alreadyAdded,i,flagempty,cum=[],[],[],-1,true,0
arr = File.read("Day09.txt").chars.map(&:to_i).map{|x| [x,(flagempty=!flagempty) ? -1 : i+=1]}

arr.each{|a,b|
  if b>=0     #Not empty spot, so just add it to result
    res << [a,b]
    alreadyAdded << [a,b]
  else        #Empty spot found, go find last element to stuff in here
    while a>0 #Empty spots are still open
      break if alreadyAdded.include?(arr[-1]) #stop edge case, big empty middle => will try to fill up with already added parts of the first half
      amt,val = arr[-1]                       #get last element to distribute
      res << [[amt,a].min,val]                #Place in result as many pieces as there is room
      arr[-1] = [amt-a,val]                   #update how many of last element are still left      
      arr.pop(2) if a>=amt                    #remove last element if all are gone (+previous empty element)
      a = [a-amt,0].max                       #update remaining empty spots
    end
  end
}
#Calc and print cumulative sum
p res.sum{|a,b|
  f=a*b*(2*cum+a-1)/2 #math stuff
  cum+=a
  f
}

#part2
#need te redo input cause i destroyed it
flagempty,i,arr,res,cum = true, -1, [], [],0
arr = File.read("Day09.txt").chars.map(&:to_i).map{|x| [x,(flagempty=!flagempty) ? -1 : i+=1]}

arr.reverse.each{|p|
  if p[1] != -1 #from the back to the front, each non empty section
    destin = arr[0..arr.index(p)].select{|a,b| a>= p[0] && b == -1}.first   #find first available spot that is: empty + roomy
    if !destin.nil?
      to_insert = [destin[0]-p[0],destin[1]]                                #empty spots left after fill
      arr[arr.index(destin)] = (destin[0] == 0) ? [p] : [p,to_insert]       #move the element and add remaining empies if >0
      arr[arr.index(p)] = [p[0],-1]                                         #Set original moved element spot to empty
      arr = arr.flatten.each_slice(2).to_a                                  #flatten array back to prevent nesting
    end
  end
}
#calculate cumulative sum
p arr.sum{|a,b|
  f= b==-1? 0 : ((2*cum+a-1)*b*a/2) #math with extra step
  cum+=a
  f
}
