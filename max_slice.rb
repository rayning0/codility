a = [5, -7, 3, 5, -2, 4, -1]

def prefix_sum(a)
  p = [0]
  (1..a.size).each do |k|
    p[k] = p[k - 1] + a[k - 1]
  end
  p
end

# p3 = a0 + a1 + a2
# p4 = a0 + a1 + a2 + a3
# p5 = a0 + a1 + a2 + a3 + a4
# p6 = a0 + a1 + a2 + a3 + a4 + a5
# sum between index x and y
# x = 3, y = 5
# p6 - p3
# p[y + 1] - p[x]

# O(n * n) - # with prefix sums
def slow_max_slice(a)
  max_slice = 0
  prefix = prefix_sum(a)
  a.size.times do |p|
    for q in p..(a.size - 1)
      sum = prefix[q + 1] - prefix[p]
      max_slice = [max_slice, sum].max
    end
  end
  max_slice
end

# O(n * n)  --- w/o prefix sums
def slow_maximal_slice(a)
  max_slice = 0
  a.size.times do |p|
    sum = 0
    for q in p..(a.size - 1)
      sum += a[q]
      max_slice = [max_slice, sum].max
    end
  end
  max_slice
end

# O(n)
def fast_max_slice(a)
  max_slice = 0 # max sum of all slices so far

  # max ending compares max slice vs. max slice + current element
  # Do we let current element into max_slice sum or not?
  # We compare to 0 because if num makes max_ending < 0,
  # we just ignore all numbers in array up to num! Start fresh.
  max_ending = 0
  a.each do |num|
    max_ending = [0, max_ending + num].max
    max_slice = [max_slice, max_ending].max
  end
  max_slice
end

p fast_max_slice(a)