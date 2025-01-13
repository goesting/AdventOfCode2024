def solve(text,colours,ring)
text.chars.zip(colours).map{|letter,colour|
  unless letter == ' '
    letter_index = ring.map{|k,v| v.index(letter)}.select{|x| !x.nil?}.first
    if colour.nil?
      possible_letters = ring.map{|k,v| [k,v[letter_index]]}
      puts "original letter (should not pick) = " + letter
      p possible_letters
      colour_selection = gets.chomp.downcase #r,g,o,b
      colour = case colour_selection
      when 'r'
        :red
      when 'g'
        :green
      when 'o'
        :orange
      when 'b'
        :blue
      end
    end

    letter_out = ring[colour][letter_index]

    #Rotate the correct coloured ring 1 step clockwise or anticlockwise(orange/green)
    rot = 1
    rot = -1 if colour == :green || colour == :orange
    ring[colour] = ring[colour].rotate(rot)
  else
    letter_out = letter #in case of spaces, just keep them
  end

  letter_out
}.join
end


red = %w(1 T G E R B J W)
green = %w(X M C 4 3 2 S F)
orange = %w(Z P H Y N U K A)
blue = %w(L O V D 5 I Q 0)
ring = {:red => red, :green => green, :orange => orange, :blue => blue}

vlaams = false #True voor vlaamse versie, false voor FR versie
if vlaams
  q1 = "JX1CS M3D 5WV2"
  q1c = [:green,:red,:orange,:red,:red,'',:red,:blue,:red,'',:red,:green,:orange,:blue]
  p solve(q1,q1c,ring)

  q2 = "R34L BTG3 DRCME XV JZ0W 3U5 P1GB"
  q2c = [:blue,:blue,:blue,:orange,'',:orange,:orange,:orange,:red,'',:red,:blue,:blue,:red,:orange,'',:red,:orange,'',:orange,:red,:red,:green,'',:red,:red,:orange,'',:red,:orange,:green,:blue]
  p solve(q2,q2c,ring)

  q3 = "DV 5V1QHS4C3 PPHC RD ZE32GS2 V2 3GXZ SXFQXOC4IZP"
  q3c = [:red,:orange,'',:red,:red,:green,:orange,:red,:blue,:blue,:blue,:red,'',:blue,:blue,:red,:red,'',:blue,:red,'',:red,:blue,:red,:blue,:orange,:blue,:red,'',:red,:orange,'',:blue,:blue,:blue,:red,'',:orange,:blue,:blue,:red,:blue,:red,:orange,:orange,:red,:red,:green]
  p solve(q3,q3c,ring)


  #start with text, and no colours. Pick colours from the system in/out until a good word is found. Save the colours picked in the colours array to skip those steps in the future
  q4 = "24UZ PP TD AT FHXY BF"
  q4c=[:blue,:blue,:blue,:red]
  p solve(q4,q4c,ring)

else
  q1 = "Y4VLCMAX X IK1R"
  q1c = [:blue,:red,:green,:orange,:red,:red,:red,:orange,'',:orange,'',:red,:green,:orange,:blue]
  p solve(q1,q1c,ring)

  q2 = "I3DAZR M5 VNSJ02B E3 LQQW"
  q2c = [:green,:blue,:orange,:red,:red,:orange,'',:red,:red,'',:orange,:red,:red,:orange,:orange,:red,:orange,'',:orange,:orange,'',:red,:orange,:green,:blue]
  p solve(q2,q2c,ring)

  q3 = "APLCXX0N1 SH 3NSN BB1TY NS GJGNSE S2 JWS3YXFRV 4PDC"
  q3c=[:red,:red,:orange,:blue,:red,:red,:green,:red,:orange,'',:blue,:red,'',:red,:blue,:orange,:blue,'',:orange,:blue,:blue,:orange,:red,'',:red,:red,]
  p solve(q3,q3c,ring)
end
