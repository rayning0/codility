# O(n)
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

# total of 1 slice, O(1)
# the totals of m slices [x..y] such that 0 <= from(x) <= to(y) < n,
# total is ax + ax+1 + . . . + ay−1 + ay.
def count_total(p, from, to)
  p[to + 1] - p[from]
end