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
def slow_coins(a)
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
puts "slow_coins. #{slow_coins(a)} tails"

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

puts "faster_coins: #{faster_coins(10)} tails"

# Each coin is flipped over exactly as many times as # of
# its divisors. The coins flipped an odd number of times show tails,
# so just find coins with ODD number of divisors.

# Every # of form k*k has odd number of divisors.
# There are exactly floor(sqrt(n)) numbers between 1 and n.
# Answer: sqrt(n) rounded to nearest integer ("floor" function) =
#         number of PERFECT SQUARES <= n
# See: math.stackexchange.com/questions/370828/number-of-perfect-squares-less-than-n

# O(1)
def fastest_coins(n)
  Math.sqrt(n).floor
end

puts "fastest_coins: #{fastest_coins(10)} tails"

# slow_coins. 3 tails
# p: 1, k: 1, coin: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
# p: 1, k: 2, coin: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
# p: 1, k: 3, coin: [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
# p: 1, k: 4, coin: [0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]
# p: 1, k: 5, coin: [0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0]
# p: 1, k: 6, coin: [0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
# p: 1, k: 7, coin: [0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0]
# p: 1, k: 8, coin: [0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0]
# p: 1, k: 9, coin: [0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0]
# p: 1, k: 10, coin: [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0]
# tails: 1
# p: 2, k: 2, coin: [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
# p: 2, k: 4, coin: [0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1]
# p: 2, k: 6, coin: [0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1]
# p: 2, k: 8, coin: [0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1]
# p: 2, k: 10, coin: [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1]
# tails: 1
# p: 3, k: 3, coin: [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
# p: 3, k: 6, coin: [0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0]
# p: 3, k: 9, coin: [0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0]
# tails: 1
# p: 4, k: 4, coin: [0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0]
# p: 4, k: 8, coin: [0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0]
# tails: 2
# p: 5, k: 5, coin: [0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0]
# p: 5, k: 10, coin: [0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0]
# tails: 2
# p: 6, k: 6, coin: [0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1]
# tails: 2
# p: 7, k: 7, coin: [0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1]
# tails: 2
# p: 8, k: 8, coin: [0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1]
# tails: 2
# p: 9, k: 9, coin: [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1]
# tails: 3
# p: 10, k: 10, coin: [0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1]
# tails: 3
# coin: [0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0]
# faster_coins: 3 tails
# fastest_coins: 3 tails