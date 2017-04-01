# https://codility.com/demo/results/trainingBTPTGH-KEE/

# return array of primes between 2 and n
def sieve(n)
  primes = [nil, nil] + (2..n).to_a
  i = 2
  while i * i <= n
    if primes[i]
      k = i * i
      while k <= n
        primes[k] = nil
        k += i
      end
    end
    i += 1
  end
  primes.compact
end

# 100% correctness, 20% performance
def slow_solution(n, p, q)
  return [0] * p.size if n == 1
  ans = []
  primes = sieve(n / 2)

  # 2. Find all semiprimes between 2 and n
  semiprimes = []
  primes.each_with_index do |prime1, i|
    primes[i..-1].each do |prime2|
      prod = prime1 * prime2
      break if prod > n
      semiprimes << prod
    end
  end
  semiprimes.sort!

  p.size.times do |i|
    ans << semiprimes.count { |semi| semi.between?(p[i], q[i]) }
  end
  ans
end

# For n = 26, first few primes = 2, 3, 5, 7, 11, 13.
# A semiprime is the product of two (not necessarily distinct) prime numbers.
# For n = 26, semiprimes are 4, 6, 9, 10, 14, 15, 21, 22, 25, 26.

def fast_solution(n, p, q)
  return [0] * p.size if n == 1
  ans = []
  # 1. Find primes between 2 and n/2.
  # Semiprime factors don't include > n/2
  primes = sieve(n / 2)

  # 2. Mark all semiprimes between 2 and n, with 1
  semiprimes = [0] * (n + 1)
  primes.each_with_index do |prime1, i|
    primes[i..-1].each do |prime2|
      prod = prime1 * prime2
      break if prod > n
      semiprimes[prod] = 1
    end
  end
# p semiprimes
# [0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1]

  # 3. Prefix sum. Rewrite semiprimes to track # of them up to index.
  (1..n).each do |i|
    semiprimes[i] += semiprimes[i - 1]
  end
# p semiprimes
# [0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 4, 4, 4, 4, 5, 6, 6, 6, 6, 6, 6, 7, 8, 8, 8, 9, 10]

  ans = []
  # 4. Loop through p, q, using answer to #2, and build answer array
  p.size.times do |i|
    # prefix sums trick. Sum of 1 slice, from p[i] to q[i]
    ans << semiprimes[q[i]] - semiprimes[p[i] - 1]
  end
  ans # [10, 4, 0]
end

# p fast_solution(1, [1, 1, 1], [1, 1, 1])
p fast_solution(26, [1, 4, 16], [26, 10, 20])
