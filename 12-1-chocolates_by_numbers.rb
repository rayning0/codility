# O(n + m)
def slow_solution(n, m)
  choc = [1] * (n)
  eat = 0
  eaten = 0
  begin
    if choc[eat]
      choc[eat] = nil
      eaten += 1
    end
    eat += m
    eat %= n if eat > n - 1
  end until choc[eat].nil?
  eaten
end

# (0 + km) % n == 0

# m = 4
# n = 10
# k = 5

# km % n = 0
# km = cn
# k  = cn / m

# This works (100% performance) but is not best way
# O(log(n + m))
def fast_solution(n, m)
  # eaten = c * n / m. Find c that makes (c * n) % m == 0.
  c = 0
  begin
    c += 1
    c = m / n if m == 1000000000
  end until (c * n) % m == 0
  c * n / m
end

# https://codility.com/demo/results/training2GZVWK-Y5D/

def gcd(u, v)
  while v > 0
    u, v = v, u % v
  end
  u
end

def lcm(u, v)
  u * v / gcd(u, v)
end

# O(log(n + m))
def fast_solution(n, m)
  # n and m meet at their Least Common Multiple
  # Dividing this LCM / m = # of steps (chocolates) that are eaten
  lcm(n, m) / m
end
