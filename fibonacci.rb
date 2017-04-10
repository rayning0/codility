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
# fib(30) = 832040, fib(31) = 1346269
require 'pry'
def check_sum_fib(a)
  f = [0, 1]
  n = 2
  m = a.max
  puts "a: #{a}"
  puts "f: #{f}, m: #{m}"
  # O(m)
  loop do
    fib = fib(n)
    break if fib > m
    f[n] = fib
    n += 1
  end
  
end

p check_sum_fib([101, 503, 2027, 6368, 12325, 37323, 923426, 124567, 734774, 523621])