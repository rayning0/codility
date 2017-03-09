# https://codility.com/programmers/lessons/7-stacks_and_queues/stone_wall/

# 0. Start at height 8. Block 1.
# 1. H still 8. Block 1. No change
# 2. H = 5 < 8. Block 2
# 3. H = 7 > 8. New height not used before. Block 3
# 4. H = 9 > 7. New height not used before. Block 4
# 5. H = 8 < 9, but same height used before. Use new block because between this and last time, our height dropped below 8. Block 5
# 6. H = 7 < 8, but same height used before. We don't use new block because  between this and last time, our height, did NOT drop below 7.
# 7. H = 4 < 7. New height not used before. Block 6
# 8. H = 8 > 4, but same height used before. Use new block because between this and last time, our height dropped below 8. Block 7

def solution(h) # Doesn't work yet! Needs fixing.
  stack = []
  blocks = 0
  before = {}
  any_height_less = false
  h.each_with_index do |height, index|
    #puts "height: #{height} "
    next if stack.empty? || height == stack.last
    if before[height] # if we've seen height before
      last_time = before[height]
      any_height_less = stack[last_time..-1].any?{|num| num < height}
      if any_height_less
        puts "see old height less than current, at index #{last_time}"
        blocks += 1
      end
    else
      blocks += 1
    end
    stack << height
    before[height] = index
    #puts "stack: #{stack}, blocks: #{blocks}"
  end
  blocks
end


h = [8, 8, 5, 7, 9, 8, 7, 4, 8]
puts "Min num of blocks: #{solution(h)}"

# def slow_solution(h) <= works 100%, but 64% Codility performance
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
