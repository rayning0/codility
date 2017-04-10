def gcd(u, v)
  while v > 0
    u, v = v, u % v
  end
  u
end

def prime_factors(n)
  f = 2
  factors = []
  while f * f <= n
    if n % f == 0
      factors << f
      n /= f
    else
      f += 1
    end
  end
  factors << n
end

# O(Z * (max(A) + max(B))**(1/2))
# 100% correct, 66% performance
def slow_solution(a, b)
  count = 0
  a.size.times do |i|
    if prime_factors(a[i]).uniq == prime_factors(b[i]).uniq
      count += 1
    end
  end
  count
end

def remove_common_prime_factors(x, y)
  # Remove all prime factors of x which also in y.
  # Return extra prime factors of x.
  while x != 1
    gcd = gcd(x, y)
    break if gcd == 1 # x has no more common prime factors
    x /= gcd # gcd includes all common prime factors of x, y
  end
  x
end

# https://codility.com/demo/results/trainingBUKR3A-FHE/
# O(Z * log(max(A) + max(B))**2)
def fast_solution(a, b)
  count = 0
  a.zip(b).each do |anum, bnum|
    gcd = gcd(anum, bnum) # gcd includes ALL common prime factors
    extra_pf = remove_common_prime_factors(anum, gcd)
    next if extra_pf != 1 # prime factors of anum, bnum aren't all common
    extra_pf = remove_common_prime_factors(bnum, gcd)
    count += 1 if extra_pf == 1
  end
  count
end

p fast_solution([15, 10, 3], [75, 30, 5])
