def range(start, finish)    # 1, 4
  return [] if finish < start
  [start] + range(start + 1, finish)
end

# range(1, 4)
# [1] + range(start + 1, finish)
#       [2] + range(2+1, finish)
#             [3] + range(3+1, 4)
#                   [4] + range(5,4)
#                         []
# p range(1, 1000)

def sum_recursion(arr)
  return 0 if arr.empty?
  sum = arr.shift
  sum += sum_of_array(arr)
          # 2 + sum_of_array([3])
              #3 + sum_of_array([])


end

def sum_iteration(array)
  sum = 0
  array.each do |num|
    sum += num
  end
  sum
end

p sum_iteration([1,2,3,4])
