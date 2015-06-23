def exp_1(num, exponent)
  return 1 if exponent == 0
  num * exp_1(num , exponent - 1)
        #2 * exp(2, 0)
            #1
end

# p exp_1(2,3)


def exp_rec2(num, exponent)
  return 1 if exponent == 0

  if exponent%2 == 0
   exp_rec2(num, exponent/2) * exp_rec2(num, exponent/2)
 else
   num * exp_rec2(num, exponent - 1)
 end
 end

end

p exp_rec2(2,8)

# ep (2,3)
# 2 * ep(2,2)
#     ep(2,1) * ep(2,1)
#     (2 * ep(2,0)) *  (2 * ep(2,0))

# ep(2,2)
# 2 * ep(2,1)
#     2 * ep(2,0)
#          1

# exp_rec2(2, 2)
# exp_rec2(2, 2/2 = 1) * exp_rec2(2, 2/2 = 1)
# exp_rec2(2, 0) * exp_rec2(2, 0)
#             1 * 1
