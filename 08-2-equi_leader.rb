def solution(a, equi = 0)
  #puts "a: #{a}, equi: #{equi}"
  return equi if a.size <= 1
  stack_count = 0
  s = new_s(a)
  left_half = a[0..s]
  right_half = a[s + 1..-1]
  left = leader(left_half)
  right = leader(right_half)
  #puts "left_half: #{left_half}, right_half: #{right_half}"
  #puts "left: #{left}, right: #{right}"
  if (left && right) && (left == right)
    stack_count += 1
  end
  #puts "stack_count: #{stack_count}"
  sol1 = solution(left_half, stack_count)
  sol2 = solution(right_half, stack_count)
  #puts "sol1 = #{sol1}, sol2 = #{sol2}\n\n"
  sol1 + sol2
end

def new_s(arr)
  s = if arr.size.even?
        arr.size / 2 - 1
      else
        arr.size / 2
      end
  s
end


def slow_solution(a)
  equi = 0
  a.size.times do |i|
    left = leader(a[0..i])
    right = leader(a[i + 1..-1])
    if (left && right) && (left == right)
      equi += 1
    end
  end
  equi
end


def leader(arr)
  leader = nil
  stack = []
  arr.each do |num|
    stack << num
    if stack.size < 2
      next
    end
    if stack.last != stack[-2]
      stack.pop(2)
    end
  end
  if arr.count(stack.last) > arr.size / 2
    leader = stack.last
  end
  return leader if leader
end

______________
Output of failed solution at top (got 11% Codility score):

Example test:    [4, 3, 4, 4, 4, 2]
Output:
a: [4, 3, 4, 4, 4, 2], equi: 0
left_half: [4, 3, 4], right_half: [4, 4, 2]
left: 4, right: 4

a: [4, 3, 4], equi: 1
left_half: [4, 3], right_half: [4]
left: , right: 4

a: [4, 3], equi: 1
left_half: [4], right_half: [3]
left: 4, right: 3

a: [4], equi: 1
a: [3], equi: 1
a: [4], equi: 1
a: [4, 4, 2], equi: 1
left_half: [4, 4], right_half: [2]
left: 4, right: 2

a: [4, 4], equi: 1
left_half: [4], right_half: [4]
left: 4, right: 4

a: [4], equi: 2
a: [4], equi: 2
a: [2], equi: 1
WRONG ANSWER  (got 8 expected 2)
__________________
Example test:    [4, 3, 4, 4, 4, 2]
Output:
a: [4, 3, 4, 4, 4, 2], equi: 0
left_half: [4, 3, 4], right_half: [4, 4, 2]
left: 4, right: 4
stack_count: 1
a: [4, 3, 4], equi: 1
left_half: [4, 3], right_half: [4]
left: , right: 4
stack_count: 0
a: [4, 3], equi: 0
left_half: [4], right_half: [3]
left: 4, right: 3
stack_count: 0
a: [4], equi: 0
a: [3], equi: 0
sol1 = 0, sol2 = 0

a: [4], equi: 0
sol1 = 0, sol2 = 0

a: [4, 4, 2], equi: 1
left_half: [4, 4], right_half: [2]
left: 4, right: 2
stack_count: 0
a: [4, 4], equi: 0
left_half: [4], right_half: [4]
left: 4, right: 4
stack_count: 1
a: [4], equi: 1
a: [4], equi: 1
sol1 = 1, sol2 = 1

a: [2], equi: 0
sol1 = 2, sol2 = 0

sol1 = 0, sol2 = 2
