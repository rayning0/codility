# https://codility.com/demo/results/trainingUM6MGK-R7K/

# 0. Start at height 8. Block 1.
# 1. H = 8 still. Block 1. Skip this H. Stack = [8]
# 2. 8 > H = 5. Only keep stuff on stack if it's < H. Keep stack in ASCENDING ORDER. Pop 8. Stack = [5]. Block 2.
# 3. 5 < H = 7. New height not used before. Stack = [5, 7]. Block 3.
# 4. 7 < H = 9. New height not used before. Stack = [5, 7, 9]. Block 4.
# 5. 9 > H = 8. Pop 9. 7 < 8, so keep it. Stack = [5, 7, 8]. Block 5.
# 6. 8 > H = 7. Pop 8. Stack = [5, 7]. Since stack.last == H, move on. Block 5.
# 7. 7 > H = 4. Pop 7 and 5. Stack = [4]. Block 6.
# 8. 4 < H = 8. Stack [4, 8]. Block 7.

def solution(h)
  blocks = 0
  stack = []
  h.each do |height|
    #puts "height: #{height}, stack: #{stack}, blocks: #{blocks}"
    while stack.size > 0 && stack.last > height
      stack.pop
    end

    next if stack.size > 0 && stack.last == height
    stack << height
    blocks += 1
  end
  blocks
end

h = [8, 8, 5, 7, 9, 8, 7, 4, 8]
puts "Min num of blocks: #{solution(h)}"

# height: 8, stack: [], blocks: 0
# height: 8, stack: [8], blocks: 1
# height: 5, stack: [8], blocks: 1
# height: 7, stack: [5], blocks: 2
# height: 9, stack: [5, 7], blocks: 3
# height: 8, stack: [5, 7, 9], blocks: 4
# height: 7, stack: [5, 7, 8], blocks: 5
# height: 4, stack: [5, 7], blocks: 5
# height: 8, stack: [4], blocks: 6
# Answer: 7 blocks

# O(n*n)
# def slow_solution(h) #<= works 100%, but 64% Codility performance
#   stack = [h.shift]
#   blocks = 1
#   h.each do |height|
#     #puts "height: #{height} "
#     next if height == stack.last
#     if stack.include?(height)
#       last_time = stack.rindex(height)
#       any_height_less = stack[last_time..-1].any?{|num| num < height}
#       if any_height_less
#         puts "see old height less than current, at index #{last_time}"
#         blocks += 1
#       end
#     else
#       blocks += 1
#     end
#     stack << height
#     #puts "stack: #{stack}, blocks: #{blocks}"
#   end
#   blocks
# end
