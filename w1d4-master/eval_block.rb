def eval_block(*args, &prc)
  return "NO BLOCK GIVEN" if prc.nil?
  prc.call(*args)
end

temp = eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end

p temp

result = eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end

p result
