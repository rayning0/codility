# find number of divisors of n

# O(n)
def slow_divisors(n)
  divisors = 0
  (1..n).each do |num|
    if n % num == 0
      divisors += 1
    end
  end
  divisors
end

# O(sqrt(n))
def divisors(n)
  divisors = 0
  i = 1
  while i * i < n
    divisors += 2 if n % i == 0
    i += 1
  end
  divisors +=1 if i * i == n
  divisors
end

# Is n prime?

# O(n)
def slow_prime?(n)
  (2..n - 1).each do |num|
    return false if n % num == 0
  end
  true
end

# O(sqrt(n))
def faster_prime?(n)
  i = 2
  while i * i < n
    return false if n % i == 0
    i += 1
  end
  true
end

# Each coin shows heads at first
# Q: How many coins, after flipping, show tails?
# After flipping 10 coins: [H, H, H,...H]
# We get [T, H, H, T, H, H, H, H, T, H]
# O(n * n)
def coins(a)
  n = a.size
  (1..n).each do |i|
    c = 1
    # person i flips all coins with multiples of i
    while c * i <= n
      a[c * i - 1] = a[c * i - 1] == 'H' ? 'T' : 'H'
      c += 1
    end
  end
  a.count('T')
end

a = ['H'] * 10
puts "num of tails: #{coins(a)}"

# O(n log n)
def faster_coins(n)
  # n = num of coins
  # p = person #
  # coin = array of coins (0 = H, 1 = T)
  # k = array index of coin we're flipping
  # tails = # of tails after all coins flipped
  tails = 0
  coin = [0] * (n + 1)
  (1..n).each do |p|
    k = p
    while k <= n
      puts "p: #{p}, k: #{k}, coin: #{coin}"
      coin[k] = (coin[k] + 1) % 2 # flips 1 -> 0, 0 -> 1
      k += p
    end
    tails += coin[p]
    puts "tails: #{tails}"

  end
  puts "coin: #{coin}"
  tails
end

puts "final tails: #{faster_coins(100)}"

# Each coin is flipped over exactly as many times as # of
# its divisors. The coins flipped an odd number of times show tails,
# so just find coins with ODD number of divisors.

# Every # of form k*k has odd number of divisors.
# There are exactly floor(sqrt(n)) such numbers between 1 and n.
# Answer: # of PERFECT SQUARES <= n
# Answer: sqrt(n) rounded to nearest integer ("floor" function)

# O(1)
def fastest_coins(n)
  Math.sqrt(n).floor
end

puts "Fastest way: #{fastest_coins(100)} tails."