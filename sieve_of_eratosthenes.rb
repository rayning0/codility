# returns array of all primes up to n
# nil means array index is prime (except 0, 1)
def sieve(n)
  primes = [nil, nil] + (2..n).to_a
  i = 2
  while i * i <= n  # i just must loop up to sqrt(n)
    if primes[i]
      k = i * i
      while k <= n
        primes[k] = nil
        k += i
      end
    end
    i += 1
  end
  primes.compact!
end

# start = Time.now
# p sieve(19)
# puts "#{Time.now - start} secs" # Took 0.3 secs

# prepare array f for prime factorization
# For every crossed number we remember the smallest prime that divides this number.
def array_f(n)
  # 0 means array index is prime (except 0, 1)
  f = [0] * (n + 1)
  i = 2
  while i * i <= n
    if f[i] == 0
      k = i * i
      while k <= n
        f[k] = i if f[k] == 0
        k += i
      end
    end
    i += 1
  end
  f
end

# p array_f(20)
# [0, 0, 0, 0, 2, 0, 2, 0, 2, 3, 2, 0, 2, 0, 2, 3, 2, 0, 2, 0, 2]

# If p = a prime factor of n, then all the prime factors of n =
# p plus prime factors of n/p
# O(log(n))
def prime_factors_bad(n) # <--BAD! Uses up TON of memory!
  f = array_f(n)
  pfactors = []
  while f[n] > 0
    pfactors << f[n]
    n /= f[n]
  end
  pfactors << n
  pfactors
end

# From Project Euler #3
def prime_factors(n)
  factors = []
  f = 2
  while f * f <= n
    if n % f == 0
      factors << f
      n /= f
    else
      f += 1
    end
  end
  factors << n
  factors
end

# can't run! Used over 20 GB RAM!
#p prime_factors_bad(600851475143)
p prime_factors(600851475143) # <- num from Project Euler
# [71, 839, 1471, 6857]
