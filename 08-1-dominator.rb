# https://codility.com/demo/results/training9V65T3-X3Q/

def solution(a)
  leader = -1
  stack = []
  a.each do |num|
    stack << num
    if stack.size < 2
      next
    end
    if stack.last != stack[-2]
      stack.pop(2)
    end
  end
  if a.count(stack.last) > a.size / 2
    leader = stack.last
  end
  return a.index(leader) if leader != -1
  -1
end