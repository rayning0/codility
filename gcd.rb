# Euclidean algorithm for Greatest Common Divisor of 2 positive integers

# Subtraction method: O(n)
def gcd_subtraction(a, b)
  return a if a == b
  if a > b
    gcd_subtraction(a - b, b)
  else
    gcd_subtraction(a, b - a)
  end
end

# Division method: O(log(a + b))
def gcd_division1(a, b)
  if a % b == 0
    return b
  else
    gcd_division1(b, a % b)
  end
end

# Or: FASTEST OF ALL 4 ALGORITHMS!!!
def gcd_division2(u, v)
  while v > 0
    u, v = v, u % v
  end
  u
end

# Binary (Stein's) algorithm:

# If u and v are both even, gcd(u,v) = 2 gcd(u/2, v/2).
# If u is even and v is odd, gcd(u,v) = gcd(u/2, v).
# Otherwise both are odd, and gcd(u,v) = gcd(|u-v|/2, v). (difference of two odd numbers is even.)

# Time complexity: O(log(a · b)) = O(log a + b) = O(log n).
# For very large integers, O((log n)^2), since each arithmetic operation can be done in O(log n) time.

# Explains each binary GCD step well:
# http://www.cse.unt.edu/~tarau/teaching/PP/NumberTheoretical/GCD/Binary%20GCD%20algorithm.pdf
# http://www.cut-the-knot.org/blue/binary.shtml

def gcd_binary(u, v)
  return v if u == 0 || u == v
  return u if v == 0

  # bitwise operations:
  # >> 1 means divide by 2
  # << 1 means multiply by 2
  if u.even? && v.even?
    return gcd_binary(u >> 1, v >> 1) << 1
  elsif u.even?
    return gcd_binary(u >> 1, v)
  elsif v.even?
    return gcd_binary(u, v >> 1)
  else
    return gcd_binary((u - v).abs >> 1, [u, v].min)
  end

  # if u.even? && v.even?
  #   return gcd_binary(u / 2, v / 2) * 2
  # elsif u.even?
  #   return gcd_binary(u / 2, v)
  # elsif v.even?
  #   return gcd_binary(u, v / 2)
  # else
  #   return gcd_binary((u - v).abs / 2, [u, v].min)
  # end
end

# Fastest to Slowest:
gcd_division2(2322, 654)
# 3.0e-06 secs

gcd_division1(2322, 654)
# 4.0e-06 secs

gcd_subtraction(2322, 654)
# 5.0e-06 secs

gcd_binary(2322, 654)
# 2.6e-05 secs


# Least Common Multiple (LCM) of a and b =
# smallest positive integer divisible by both a and b
#
# lcm(a, b) = a * b / gcd(a, b)
#
# Intuitive reason: a * b is clearly divisible by both a and b.
# How to get SMALLEST divisible integer?
# Divide by BIGGEST possible integer, the GREATEST COMMON DIVISOR.

# lcm(a1, a2, ..., an) = lcm(a1, lcm(a2, a3, ... , an))

def lcm(*a) # LCM of multiple numbers
  if a.size == 2
    return a[0] * a[1] / gcd_division2(a[0], a[1])
  end

  lcm(a.shift, lcm(*a))
end

p lcm(16, 20, 24, 41) # 9840