# https://codility.com/demo/results/trainingAG7YKJ-6QQ/
# If you have array A with leader z (leader = unique element that occurs more than in half of array), then for every separation of A into A[0..i), A[i..n), if they have the same leader, then the leader of both is z.

# This follows from noticing that if x is a leader in A[0..i), then it occurs more than ⌈i/2⌉ elements, and similarly, if y is the leader of A[i..n), then y occurs more than ⌈(n−i)/2⌉.

# If both slices have leader z, it must occur more than ⌈n/2⌉, which means that y=x as required.

a = [4, 3, 4, 4, 4, 2]

# O(n)
def fast_solution(a)
  equileaders = 0

  # 1. Find leader candidate
  candidate = a.first
  count = 1
  a.size.times do |i|
    a[i] == candidate ? count += 1 : count -= 1
    if count == 0
      count = 1
      candidate = a[i]
    end
  end

  # 2. Is candidate a leader?
  total_leaders = a.count(candidate)
  if total_leaders <= a.size / 2
    return 0 # no leaders in array
  else
    leader = candidate
  end

  # 3. Loop through all possible left/right divisions of array.
  # From left/right leader counts, count which meet criteria of equileaders.
  left_leader_count = 0
  a.size.times do |i|
    left_leader_count += 1 if a[i] == leader
    right_leader_count = total_leaders - left_leader_count

    # i + 1 = length of left side
    # a.size - 1 - i = length of right side
    # (i + 1) + (a.size - 1 - i) = a.size
    if left_leader_count > (i + 1) / 2 &&
       right_leader_count > (a.size - 1 - i) / 2
      equileaders += 1
    end
  end
  equileaders
end

#_________________________
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
