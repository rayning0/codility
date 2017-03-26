# https://codility.com/demo/results/trainingXVMN7F-2KA/

class Tree
  attr_accessor :x, :l, :r

  def initialize(x, l, r)
    @x, @l, @r = x, l, r
  end
end

# Original binary tree:
# (5, (3, (20, None, None), (21, None, None)), (10, (1, None, None), None))
t20 = Tree.new(20, nil, nil)
t21 = Tree.new(21, nil, nil)
t1 = Tree.new(1, nil, nil)
t3 = Tree.new(3, t20, t21)
t10 = Tree.new(10, t1, nil)
t5 = Tree.new(5, t3, t10)

def solution(t)
  # print "#{t.x} " if t
  return 0 if t.nil? || (t.l.nil? && t.r.nil?)
  1 + [solution(t.l), solution(t.r)].max
end

puts solution(t5)
# Output (visits nodes in this order):
# 5 3 20 21 10 1
# Height: 2

# Test: (5, (3, (20, None, None), (21, None, (23, (26, None, (27, None, None)), None))), (10, (1, None, (22, (29, None, (30, None, None)), (24, (25, None, (28, None, None)), None))), None))
t20 = Tree.new(20, nil, nil)
t27 = Tree.new(27, nil, nil)
t26 = Tree.new(26, nil, t27)
t23 = Tree.new(23, t26, nil)
t21 = Tree.new(21, nil, t23)
t3  = Tree.new(3, t20, t21)
t30 = Tree.new(30, nil, nil)
t28 = Tree.new(28, nil, nil)
t25 = Tree.new(25, nil, t28)
t24 = Tree.new(24, t25, nil)
t29 = Tree.new(29, nil, t30)
t22 = Tree.new(22, t29, t24)
t1  = Tree.new(1, nil, t22)
t10 = Tree.new(10, t1, nil)
t5  = Tree.new(5, t3, t10)

puts solution(t5)
# Output (visits nodes in this order):
# 5 3 20 21 23 26 27 10 1 22 29 30 24 25 28
# Height: 6


# Test: (5, (3, (20, None, (22, None, None)), (21, None, None)), (10, (1, None, None), None))
# Output (visits nodes in this order):
# 5 3 20 22 21 10 1
# Height: 3
