def fibonacci(n)
  if n == 1
    return [0]
  elsif n == 2
    return [0,1]
  else
    prev = fibonacci(n-1)
    prev << (prev[-1] + prev[-2])
  end
end

p fibonacci(5) # 3
p fibonacci(12) # 89
