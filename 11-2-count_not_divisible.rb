# https://codility.com/demo/results/trainingMQHP6E-KXY/

# O(log n)
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

# O(n*n) 100% correct, 0% performance
def slow_solution(a)
  ans = []
  a.size.times do |i|
    primes = prime_factors(a[i]) # log n
    nondivisors = a - primes - [1, a[i]]
    ans << nondivisors.size - nondivisors.select {|nd| a[i] % nd == 0}.size
  end
  ans
end

# a = [3, 1, 2, 3, 6, 12]
# O(n log n)
def fast_solution(a)
  nondivisors = []
  amax = a.max
  freq = Hash.new(0)
  divisors = {}

  # Frequency hash of each num
  # Initialize hash of divisors of each num
  a.each do |num|
    freq[num] += 1
    divisors[num] = num == 1 ? [1] : [1, num]
  end
# freq: {3=>2, 1=>1, 2=>1, 6=>1, 12=>1}
# divisors: {3=>[1, 3], 1=>[1], 2=>[1, 2], 6=>[1, 6], 12=>[1, 12]}

  # Sieve of Eratosthenes: Hash of divisors of each num
  div = 2
  while div * div <= amax
    num = div
    while num <= amax
      if divisors[num] && !divisors[num].include?(div)
        divisors[num] << div
        divisors[num] << num / div
      end
      num += div
    end
    div += 1
  end
  # divisors: {3=>[1, 3], 1=>[1], 2=>[1, 2], 6=>[1, 6, 2, 3], 12=>[1, 12, 2, 6, 3, 4]}

  a.each do |num|
    num_of_divisors = 0
    divisors[num].uniq.each do |div|
      num_of_divisors += freq[div]
    end
    nondivisors << a.size - num_of_divisors
  end
  nondivisors
end

p fast_solution([3, 1, 2, 3, 6, 12])
# nondivisors: [3, 5, 4, 3, 1, 0]
# _________________________________
# freq: {3=>2, 1=>1, 2=>1, 6=>1, 12=>1}
# divisors: {3=>[1, 3], 1=>[1], 2=>[1, 2], 6=>[1, 6], 12=>[1, 12]}
# div: 2
# num: 2
# divisors[2]: [1, 2]
# num: 4
# divisors[4]:
# num: 6
# divisors[6]: [1, 6, 2, 3]
# num: 8
# divisors[8]:
# num: 10
# divisors[10]:
# num: 12
# divisors[12]: [1, 12, 2, 6]
# div: 3
# num: 3
# divisors[3]: [1, 3]
# num: 6
# divisors[6]: [1, 6, 2, 3]
# num: 9
# divisors[9]:
# num: 12
# divisors[12]: [1, 12, 2, 6, 3, 4]
# final divisors: {3=>[1, 3], 1=>[1], 2=>[1, 2], 6=>[1, 6, 2, 3], 12=>[1, 12, 2, 6, 3, 4]}
# nondivisors: [3, 5, 4, 3, 1, 0]
