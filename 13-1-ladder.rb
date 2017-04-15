# https://codility.com/demo/results/trainingJGVJ86-CE8/

a = [4, 4, 5, 5, 1]
b = [3, 2, 4, 3, 1]

# returns Fibonacci sequence:
# ways(1) = 1, ways(2) = 2, ways(3) = 3, ways(4) = 5, ways(5) = 8, etc.
def ways(n, c = 0)
  if n == 0
    c += 1
    return c
  end
  return 0 if n < 0
  ways(n - 1, c) + ways(n - 2, c)
end

def slow_solution(a, b)
  ans = []
  w = []
  a.size.times do |i|
    unless w[a[i]]
      w[a[i]] = ways(a[i])
    end
    ans << w[a[i]] % 2**b[i]
  end
  ans
end

# O(L), L = size of a, b arrays
def fast_solution(a, b)
  ans = []
  ways = [1, 1]
  (2..a.max).each do |n|
    # ways to climb ladder is just Fibonacci sequence!
    ways[n] = ways[n - 1] + ways[n - 2]
  end

  a.size.times do |i|

    # If d = power of 2, d & (d - 1) = 0
    # x % d = (x & (d − 1)), where & is bitwise AND.
    # Also, x / d = x >> power, where 2^power = d
    # http://stackoverflow.com/questions/6670715/mod-of-power-2-on-bitwise-operators/6670853#6670853
    # http://blog.teamleadnet.com/2012/07/faster-division-and-modulo-operation.html
    ans << (ways[a[i]] & (2**b[i] - 1))
  end
  ans
end

start = Time.now
p slow_solution(a, b)
puts "#{Time.now - start} secs" # 6.6e-05

start = Time.now
p fast_solution(a, b)
puts "#{Time.now - start} secs" # 3.0e-05