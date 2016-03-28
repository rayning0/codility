# https://codility.com/demo/results/trainingVHF4TQ-QC5/
# https://codility.com/programmers/lessons/3

def solution(s, p, q)
  genoms = Array.new(3) {Array.new(s.length + 1, 0)}
  s.length.times do |i|
    a, c, g = 0, 0, 0
    a = 1 if s[i] == 'A'
    c = 1 if s[i] == 'C'
    g = 1 if s[i] == 'G'
    # prefix sums:
    # How many of each letter have we seen so far, left to right?
    genoms[0][i + 1] = genoms[0][i] + a
    genoms[1][i + 1] = genoms[1][i] + c
    genoms[2][i + 1] = genoms[2][i] + g
  end

  result = []
  p.length.times do |i|
    from = p[i]
# we add 1 to q[i], because our genoms[0][0], genoms[1][0] and genoms[2][0]
# have 0 values by default, so look above genoms[0][i+1] = genoms[0][i] + a;
    to = q[i] + 1
    # count total: finds # of each letter between indices 'from' and 'to'
    # If we see at least 1 of that letter, we're done, because we seek
    # minimum value letter. Put in result.
    if genoms[0][to] - genoms[0][from] > 0  # Do we see at least 1 A?
      result[i] = 1
    elsif genoms[1][to] - genoms[1][from] > 0 # Do we see at least 1 C?
      result[i] = 2
    elsif genoms[2][to] - genoms[2][from] > 0 # Do we see at least 1 G?
      result[i] = 3
    else
      result[i] = 4
    end
  end
  result
end

# p solution('CAGCCTA', [2, 5, 0], [4, 5, 6])

# O(n)
def prefix_sums(arr)
  n = arr.length
  p = [0]
  (1..n).each do |k|
    p[k] = p[k - 1] + arr[k - 1]
    puts "p[#{k}]= #{p[k]}"
  end
  p
end

# total of 1 slice, O(1)
# the totals of m slices [x..y] such that 0 <= from(or x) <= to(or y) < n,
# where the total is the sum ax + ax+1 + . . . + ay−1 + ay.
def count_total(p, from, to)
  p[to + 1] - p[from]
end