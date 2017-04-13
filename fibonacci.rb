# http://introcs.cs.princeton.edu/java/23recursion/ (theory)

# recursive
# O(2^n)
def fib(n, c)
  indent = ' ' * c
  puts "#{indent}fibonacci(#{n})"
  return n if n <= 1
  fib(n - 2, c + 2) + fib(n - 1, c + 2)
end

#p fib(7, 0)

# Recursion sucks here: O(2^n)

# fibonacci(7)
#   fibonacci(5)
#     fibonacci(3)
#       fibonacci(1)
#       fibonacci(2)
#         fibonacci(0)
#         fibonacci(1)
#     fibonacci(4)
#       fibonacci(2)
#         fibonacci(0)
#         fibonacci(1)
#       fibonacci(3)
#         fibonacci(1)
#         fibonacci(2)
#           fibonacci(0)
#           fibonacci(1)
#   fibonacci(6)
#     fibonacci(4)
#       fibonacci(2)
#         fibonacci(0)
#         fibonacci(1)
#       fibonacci(3)
#         fibonacci(1)
#         fibonacci(2)
#           fibonacci(0)
#           fibonacci(1)
#     fibonacci(5)
#       fibonacci(3)
#         fibonacci(1)
#         fibonacci(2)
#           fibonacci(0)
#           fibonacci(1)
#       fibonacci(4)
#         fibonacci(2)
#           fibonacci(0)
#           fibonacci(1)
#         fibonacci(3)
#           fibonacci(1)
#           fibonacci(2)
#             fibonacci(0)
#             fibonacci(1)
# 13

# iterative (bottom up)
# O(n)
def fib(n)
  return n if n <= 1
  f = [0, 1]
  (2..n).each do |i|
    f[i] = f[i - 2] + f[i - 1]
  end
  f[n]
end

#p fib(10) # answer 55

# recursive (top down)
# O(2n) = O(n)
class TopDownFib
  def initialize
    @f = [0, 1]
  end

  def fib(n)
    return n if n <= 1
    return @f[n] if @f[n]
    @f[n] = fib(n - 2) + fib(n - 1)
  end
end

#p TopDownFib.new.fib(15) # answer 89

# For all given numbers x0, x1,...,xn-1, such that 1 <= xi <= m <= 1,000,000,
# check if they may be presented as sum of two Fibonacci numbers.
# fib(30) = 832040, fib(31) = 1346269 (> 1,000,000)

# O(n + m)
def check_sum_fib(a)
  f = [0, 1]
  n = 2
  m = a.max
  puts "a: #{a}, m: #{m}"
  loop do
    fib = fib(n)
    break if fib > m
    f[n] = fib
    n += 1  # max value = 30
  end
  puts "Fib nums: #{f}"
  fib_sum = []

  (0..f.size - 2).each do |i|
    (i + 1..f.size - 1).each do |j|
      k = f[i] + f[j]
# If some of the Fibonacci #'s sum to k <= m, we mark index k in array to 
# denote that k can be presented as sum of two Fibonacci numbers.
      fib_sum[k] = [f[i], f[j]] if k <= m
    end
  end

# for each number xi we can answer whether it is the sum of two Fibonacci
# numbers in constant time. The total time complexity is O(n + m).
  a.each do |num|
    if fib_sum[num]
      puts "#{num} is sum of #{fib_sum[num]}."
    end
  end
end

check_sum_fib([29, 178, 2584, 6368, 12325, 37323, 242786, 346468, 734774, 635622])

# Fib nums: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229]
# 29 is sum of [8, 21].
# 178 is sum of [34, 144].
# 2584 is sum of [987, 1597].
# 242786 is sum of [46368, 196418].
# 346468 is sum of [28657, 317811].
# 635622 is sum of [121393, 514229].