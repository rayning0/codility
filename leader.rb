
A = [4, 6, 6, 6, 6, 8, 8]
n = 7
size =
value = 6
k = 5
A[k] = 8

# def hash_leader(n)
#   freq = Hash.new(0)
#   n.each do |num|
#     freq[num] += 1
#   end

#   max_freq = freq.values.max
#   if max_freq > n.size / 2
#     return freq.key(max_freq)
#   end
# end

# O(n*n)
def slow_leader(n)
  length = n.size
  leader = -1
  n.each do |candidate|
    count = 0
    n.each do |num|
      count += 1 if num == candidate
    end
    leader = candidate if count > length/2
  end
  leader
end

# O(n log n) because sort method is O(n log n)
def fast_leader(n)
  n.sort!
  length = n.size
  leader = -1
  freq = 0
  candidate = n[length / 2]
  n.each do |num|
    freq += 1 if num == candidate
    leader = candidate if freq > length / 2
  end
  leader
end

# O(n)
def golden_leader(n)
  stack = []
  leader = -1
  stack_i = 0
  n.each do |num|
    stack << num
    if stack_i == 0
      stack_i += 1
      next
    end
    if stack[stack_i] != stack[stack_i - 1]
      stack.pop(2)
      stack_i -= 2
    end
    stack_i += 1
  end
  candidate = stack.last

  freq = 0
  n.each do |num|
    freq += 1 if num == candidate
    leader = candidate if freq > n.size / 2
  end
  leader
end

p golden_leader(n)

Python solution from PDF:

def goldenLeader(A):
  n = len(A)
  size = 0
  for k in xrange(n):
    if (size == 0):
      size += 1
      value = A[k]
    else:
      if (value != A[k]):
        size -= 1
      else:
        size += 1
  candidate = -1
  if (size > 0):
    candidate = value
  leader = -1
  count = 0
  for k in xrange(n):
    if (A[k] == candidate):
      count += 1
  if (count > n // 2):
    leader = candidate
  return leader