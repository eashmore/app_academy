def deep_dup(array)
  result = []

  array.each do |obj|
    if obj.is_a?(Array)
      result << deep_dup(obj)
    else
       result << obj
    end
  end
  result
end


p deep_dup([1, [2], [3, [4]]] )

# [1, deepdup([2]) ]
#       [2]
# only the arrays are duplicated, not the objects inside them
