def bsearch(array, target)
  #p array
  return nil if array.empty?
  midpoint = (array.length) / 2

  if array[midpoint] == target
    return midpoint

  elsif array[midpoint] > target
    bsearch(array.take(midpoint), target)

  elsif array[midpoint] < target
    result = bsearch(array[(midpoint + 1)..-1], target)
    return nil if result.nil?
    midpoint + 1 + result
  end

end
















# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
          #0  1  2  3  4  5
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
                #m  0  1  2
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil


#2     +     #[4,5,6]
              #1  +  [6]
                      #0

                      # unless array[midpoint]
                      #   return nil
                      # end

                      # p array
                      # p midpoint
