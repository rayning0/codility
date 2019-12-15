# Dynamic Programming problems have 2 requirements:

# 1. Optimal Substructure: an optimal solution can be constructed from optimal solutions of its subproblems.
# 2. Overlapping Subproblems: can be broken down into subproblems which are reused several times or a recursive algorithm for the problem solves the same subproblem over and over, rather than generating new subproblems.

# http://projecteuler.net/problem=31
# http://www.mathblog.dk/project-euler-31-combinations-english-currency-denominations/

# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:
# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# Q: How many different ways can £2 be made using any number of coins?

# Best video explanation: https://www.youtube.com/watch?v=jaNZ83Q3QGc
def coin_sum(target)
  coins = [1, 2, 5, 10, 20, 50, 100, 200]
  ways = Array.new(201, 0)
  ways[0] = 1

  coins.each do |coin|
    # puts "coin: #{coin}"
    (coin..target).each do |sum|
      # puts "sum: #{sum}. sum-coin: #{sum-coin}"
      ways[sum] += ways[sum - coin]
      # puts "ways[#{sum}]: #{ways[sum]}"
    end
  end
  ways[target]
end

p coin_sum(200)
# 73682 ways

# https://www.hackerrank.com/challenges/ctci-coin-change/problem
# https://www.youtube.com/watch?v=sn0DWI-JdNA
# Q: How many different ways can 200 be made using any number of coins?
# recursive:
def make_change(coins, money, index)
  return 1 if money == 0
  return 0 if index >= coins.size

  amount_with_coin = 0
  ways = 0

  while amount_with_coin <= money
    remaining = money - amount_with_coin
    ways += make_change(coins, remaining, index + 1)
    amount_with_coin += coins[index]
  end

  ways
end

p make_change([1, 2, 5, 10, 20, 50, 100, 200], 200, 0)
# 73682 ways

# make 2D dynamic programming array (rows = coins, cols = 0..amount)
# http://algorithms.tutorialhorizon.com/dynamic-programming-coin-change-problem/
def coin_sum_ways(coins, amount)
  solution = Array.new(coins.size + 1) { Array.new(amount + 1, 0) }

  # if amount = 0, we have 1 way (empty set) to make this
  (coins.size + 1).times do |row|
    solution[row][0] = 1
  end

  (1..coins.size).each do |row|
    (1..amount).each do |col|
      coin = coins[row - 1]
      # if coin value is <= sum
      if coin <= col
        solution[row][col] = solution[row - 1][col] + solution[row][col - coin]
      else
        # copy val from row above
        solution[row][col] = solution[row - 1][col]
      end
    end
  end

  solution[coins.size][amount]
end

coins = [1,2,3]
amount = 5

# Solution matrix:
# [[1, 0, 0, 0, 0, 0],
#  [1, 1, 1, 1, 1, 1],
#  [1, 1, 2, 2, 3, 3],
#  [1, 1, 2, 3, 4, 5]]

# 5 ways

p coin_sum_ways(coins, amount)
coins = [1, 2, 5, 10, 20, 50, 100, 200]
amount = 200
# 73682 ways

# ---------------------- Codility --------------------------------------
# https://codility.com/media/train/15-DynamicProgramming.pdf
# Time and space complexity: O(n*k)
require 'pp'

# MAXINT = (2**(0.size * 8 -2) -1)
MAXINT = 100 # Or pick any number, like 100, bigger than all numbers below row 0

def dynamic_coin_changing(coins, amount)
  puts "Coins: #{coins}. Amount wanted: #{amount}"
  solution = Array.new(coins.size + 1) { Array.new(amount + 1, 0) }

  # if no coins and the amount > 0, there's no solution, so solution[0, j] = MAXINT or infinity
  solution[0] = [0] + [MAXINT] * amount

  (1..coins.size).each do |row|
    coin = coins[row - 1]

# if the amount to be paid is smaller than highest denomination
# "coin at current row," ignore this coin and copy solution from previous row:
# (for row > 0 and col < "coin at current row")
    (0..coin - 1).each do |col|
      solution[row][col] = solution[row - 1][col]
    end

    # Ex: For coin value 4, loop from cols 0-3.
    puts "\nRow: #{row}. Coin: #{coin}. Loop of cols from 0 to #{coin - 1}:"
    pp solution

# Choose option w/ fewer coins. Either:
# 1. Use highest value coin and a smaller amount to be paid remains:
#   solution[row][col - coin] + 1
# 2. Don’t use highest value coin and keep answer from previous row
#   solution[row - 1][col]
# (for row > 0 and col >= "coin at current row").
    (coin..amount).each do |col|
      solution[row][col] = [solution[row][col - coin] + 1, solution[row - 1][col]].min
    end

    # Ex: For coin value 4, loop from cols 4-6
    puts "loop of cols from Coin: #{coin} to Amount: #{amount}:"
    pp solution
  end

  puts
  "Min # of coins that sum to amount #{amount}: #{solution[coins.size][amount]}"
end

coins = [1, 3, 4]
amount = 6
puts dynamic_coin_changing(coins, amount)

# Coins: [1, 3, 4]. Amount wanted: 6

# Row: 1. Coin: 1. Loop of cols from 0 to 0:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 0, 0, 0, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0]]
# loop of cols from Coin: 1 to Amount: 6:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 0, 0, 0, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0]]

# Row: 2. Coin: 3. Loop of cols from 0 to 2:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 1, 2, 0, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0]]
# loop of cols from Coin: 3 to Amount: 6:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 1, 2, 1, 2, 3, 2],
#  [0, 0, 0, 0, 0, 0, 0]]

# Row: 3. Coin: 4. Loop of cols from 0 to 3:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 1, 2, 1, 2, 3, 2],
#  [0, 1, 2, 1, 0, 0, 0]]
# loop of cols from Coin: 4 to Amount: 6:
# [[0, 100, 100, 100, 100, 100, 100],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 1, 2, 1, 2, 3, 2],
#  [0, 1, 2, 1, 1, 2, 2]]

# "Min # of coins that sum to amount 6: 2"

puts
# More efficient solution. We only use previous row to find new row.
# We don’t need to remember all rows.
# Time complexity: O(n*k). Space complexity: O(k).
def dynamic_coin_changing_optimized(coins, amount)
  solution = [0] + [MAXINT] * amount
  (1..coins.size).each do |row|
    coin = coins[row - 1]

    (coin..amount).each do |col|
      solution[col] = [solution[col - coin] + 1, solution[col]].min
    end

    puts "loop of cols from Coin: #{coin} to Amount: #{amount}:"
    p solution
  end

  puts
  "Min # of coins that sum to amount #{amount}: #{solution[amount]}"
end
puts dynamic_coin_changing_optimized(coins, amount)

# loop of cols from Coin: 1 to Amount: 6:
# [0, 1, 2, 3, 4, 5, 6] <- matches line 162
# loop of cols from Coin: 3 to Amount: 6:
# [0, 1, 2, 1, 2, 3, 2] <- matches line 174
# loop of cols from Coin: 4 to Amount: 6:
# [0, 1, 2, 1, 1, 2, 2] <- matches line 186

# Min # of coins that sum to amount 6: 2

#----------
# A small frog wants to get from position 0 to k (1 <= k <= 10000).
# The frog can jump over any one of n fixed distances s0,s1,...,sn−1 (1 <= si <= k).
# The goal is to count the number of different ways in which the frog can jump to position k.
# To avoid overflow, it is sufficient to return the result modulo q, where q is a given number.

# There is exactly one way for the frog to jump to position 0, so dp[0] = 1
#
# The number of ways in which the frog can jump to position j with a final jump of si is dp[j − si].
# Thus, the number of ways in which the frog can get to position j is increased
# by the number of ways of getting to position j − si, for every jump si.
def frog(s, k, q)
  dp = [1] + [0] * k
  (1..k).each do |j|
    s.size.times do |i|
      if s[i] <= j
        dp[j] = (dp[j] + dp[j - s[i]]) % q
      end
    end
  end

  dp
end

p frog([2,3,4], 10, 10)
# output: [1, 0, 1, 1, 2, 2, 4, 5, 8, 1, 7]
# But I don't know what it means.
