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

MAXINT = (2**(0.size * 8 -2) -1)
def dynamic_coin_changing(coins, amount)
  solution = Array.new(coins.size + 1) { Array.new(amount + 1, 0) }
  solution[0] = [0] + [MAXINT] * amount
  (1..coins.size).each do |row|
    coin = coins[row - 1]
# if the amount to be paid is smaller than the highest denomination
# "coin at current row," ignore this coin and copy solution from previous row:
# (for all row > 0 and col such that "coin at current row" > col);
    (0..coin - 1).each do |col|
      solution[row][col] = solution[row - 1][col]
    end

# choose option w/ fewer coins:
# 1. Use highest value coin, and a smaller amount to be paid remains, OR
#   solution[row][col - coin] + 1
# 2. Don’t use highest value coin and keep answer from previous row
#   solution[row - 1][col]
# (for all row > 0 and all col such that "coin at current row" <= col).
    (coin..amount).each do |col|
      solution[row][col] = [solution[row][col - coin] + 1, solution[row - 1][col]].min
    end
  end
  solution[coins.size][amount]
end

# [[0, INFINITY, INFINITY, INFINITY, INFINITY, INFINITY, INFINITY],
#  [0, 1, 2, 3, 4, 5, 6],
#  [0, 1, 2, 1, 2, 3, 2],
#  [0, 1, 2, 1, 1, 2, 2]]
#
#  Ans: 2

coins = [1, 3, 4]
amount = 6
p dynamic_coin_changing(coins, amount)

# To calculate "solution,"" we only use previous row. We don’t need to remember all rows.
def dynamic_coin_changing_optimized(coins, amount)
  solution = [0] + [MAXINT] * amount
  (1..coins.size).each do |row|
    coin = coins[row - 1]
    (coin..amount).each do |col|
      solution[col] = [solution[col - coin] + 1, solution[col]].min
    end
  end
  solution[amount]
end
p dynamic_coin_changing_optimized(coins, amount)

# [0, 1, 2, 1, 1, 2, 2]
# Ans: 2

# A small frog wants to get from position 0 to k (1 <= k <= 10000).
# The frog can jump over any one of n fixed distances s0,s1,...,sn−1 (1 <= si <= k).
# The goal is to count the number of different ways in which the frog can jump to position k.
# To avoid overflow, it is sufficient to return the result modulo q, where q is a given number.

# There is exactly one way for the frog to jump to position 0, so dp[0] = 1
#
# The number of ways in which the frog can jump to position j with a final jump of si is dp[j − si].
# Thus, the number of ways in which the frog can get to position j is increased by the number of ways of getting to position j − si, for every jump si.
def frog(s, k, q)
  dp = [1] + [0] * k
  (1..k).each do |j|
    s.size.times do |i|
      if s[i] <= j
        dp[j] = (dp[j] + dp[j - s[i]]) % q
      end
    end
  end
end
