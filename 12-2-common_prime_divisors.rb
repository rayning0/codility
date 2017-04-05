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

p solution([15, 10, 3], [75, 30, 5])
