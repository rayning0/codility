# https://codility.com/demo/results/trainingRHJT3Z-MTV/

# If P < Q, then fish P is initially upstream of fish Q
# Array B contains the directions of the fish. It contains only 0s and/or 1s, where:
# 0 represents a fish flowing upstream,
# 1 represents a fish flowing downstream.

# Two fish P and Q meet each other when P < Q, B[P] = 1 and B[Q] = 0, and there are no living fish between them. After they meet:

# If A[P] > A[Q] then P eats Q, and P will still be flowing downstream,
# If A[Q] > A[P] then Q eats P, and Q will still be flowing upstream.

# Q: calculate the number of fish that will stay alive.

# a = [4, 3, 2, 1, 5]
# b = [0, 1, 0, 0, 0]

a = [6, 3, 2, 1, 4, 5]
b = [0, 1, 0, 1, 0, 0]

# [[6, 0]]
# [[6, 0]] << [3, 1]
# [[6, 0], [3, 1]]
# [[6, 0], [3, 1]] << [2, 0]? NO! - fish to right is eaten
# [[6, 0], [3, 1]] << [1, 1]? YES - no one dies
# [[6, 0], [3, 1], [1, 1]]
# [[6, 0], [3, 1], [1, 1]] << [4, 0]? YES - fish to left is eaten
# [[6, 0], [3, 1]]  ans.pop
# [[6, 0]] - ans.pop, then stops
# [[6, 0], [4, 0]]
# [[6, 0], [4, 0]] << [5, 0]? YES - no one dies
# [[6, 0], [4, 0], [5, 0]]

# Answer: 3 fish are left

# 100% correctness, 100% performance. O(n).
def solution(a, b)
  stack = [[a[0], b[0]]]
  if a.size > 1
    (1..a.size - 1).each do |i|
      if stack.last[1] <= b[i]
        stack << [a[i], b[i]] # no one dies
        next
      end
      while stack.size > 0 && stack.last[0] < a[i] && stack.last[1] > b[i] # fish to left dies
        stack.pop
      end
      if stack.size == 0 || stack.last[1] == b[i]
        stack << [a[i], b[i]]
      end
    end
  end
  stack.size
end

p solution(a, b)

# 100% correctness, but O(n*n)

# def solution(a, b)
#   found_one_and_zero = true
#   while found_one_and_zero
#     found_one_and_zero = false
#     (0..b.size - 2).each do |i|
#       if b[i] == 1 && b[i + 1] == 0
#         found_one_and_zero = true
#         if a[i] > a[i + 1]
#           a[i + 1] = a[i]
#           b[i + 1]= 1
#           a[i], b[i]  = nil, nil
#         else
#           a[i] = a[i + 1]
#           b[i] = 0
#           a[i + 1], b[i + 1] = nil, nil
#         end
#       end
#       puts "b: #{b}"
#       puts "a: #{a}"
#     end
#     puts "found_one_and_zero: #{found_one_and_zero}"
#     b.select! {|fish| !fish.nil?}
#     a.select! {|fish| !fish.nil?}
#   end
#   puts "b: #{b}"
#   b.size
# end
