# Q: https://app.codility.com/programmers/lessons/17-dynamic_programming/number_solitaire/
# A: https://app.codility.com/demo/results/training7SDE4H-J5G/

a = [1, -2, 0, 9, -1, -2]
a2 = [0, -1, -2, -3, -4, -5, -6, -7] # length > 7

# http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch04s13.html
# http://nizhu.github.io/ruby-intro-site/blog/2013/07/28/numbers/
MININT = -(2**(0.size * 8 -2) -1) - 1

# - Goal: move pebble to last element of array
# - Throw 6-sided die to get k. 1 <= k <= 6
# - Move pebble from square i to i + k
# - If i + k off the board, throw die again

# STRATEGY:
# - Greedy algorithm won't work, since we may have negative values!
# - Dynamic programming. For each move, take max of 2 choices:
# 1. starting value + value at that col
# 2. Last value at that col

# Time complexity: O(n * n). Space complexity: O(n)
def solution(a)
  # [1, -INFINITY, -INFINITY, -INFINITY, -INFINITY, -INFINITY]
  # [1,-1, 1, 10, 0, -1] row = 1. start_val = 1
  # [1,-1, 1, 10, 0, -1] row = 2. start_val = -1
  # [1,-1, 1, 10, 0, -1] row = 3. start_val = 1
  # [1,-1, 1, 10, 9, 8] row = 4. start_val = 10
  # [1,-1, 1, 10, 9, 8] row = 5. start_val = 9

  dp = [a[0]] + [MININT] * (a.size - 1)
  (1..a.size - 1).each do |row|
    start_index = row - 1
    start_val = dp[start_index]

    # we may only move forward up to 6 spots
    end_col = [a.size - 1, start_index + 6].min
    puts "start_val: #{start_val}. Inner loop start_col: #{row} / end_col: #{end_col}"

    (row..end_col).each do |col|
      puts "row: #{row}, col: #{col}"
      dp[col] = [dp[col], start_val + a[col]].max
    end
    p dp
    puts
  end

  "Answer: #{dp.last}"
end

p solution(a)
puts "------------------------------------"
p solution(a2)

# OUTPUT:

# start_val: 1. Inner loop start_col: 1 / end_col: 5
# row: 1, col: 1
# row: 1, col: 2
# row: 1, col: 3
# row: 1, col: 4
# row: 1, col: 5
# [1, -1, 1, 10, 0, -1]

# start_val: -1. Inner loop start_col: 2 / end_col: 5
# row: 2, col: 2
# row: 2, col: 3
# row: 2, col: 4
# row: 2, col: 5
# [1, -1, 1, 10, 0, -1]

# start_val: 1. Inner loop start_col: 3 / end_col: 5
# row: 3, col: 3
# row: 3, col: 4
# row: 3, col: 5
# [1, -1, 1, 10, 0, -1]

# start_val: 10. Inner loop start_col: 4 / end_col: 5
# row: 4, col: 4
# row: 4, col: 5
# [1, -1, 1, 10, 9, 8]

# start_val: 9. Inner loop start_col: 5 / end_col: 5
# row: 5, col: 5
# [1, -1, 1, 10, 9, 8]

# "Answer: 8"
# ------------------------------------
# start_val: 0. Inner loop start_col: 1 / end_col: 6
# row: 1, col: 1
# row: 1, col: 2
# row: 1, col: 3
# row: 1, col: 4
# row: 1, col: 5
# row: 1, col: 6
# [0, -1, -2, -3, -4, -5, -6, -4611686018427387904]

# start_val: -1. Inner loop start_col: 2 / end_col: 7
# row: 2, col: 2
# row: 2, col: 3
# row: 2, col: 4
# row: 2, col: 5
# row: 2, col: 6
# row: 2, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# start_val: -2. Inner loop start_col: 3 / end_col: 7
# row: 3, col: 3
# row: 3, col: 4
# row: 3, col: 5
# row: 3, col: 6
# row: 3, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# start_val: -3. Inner loop start_col: 4 / end_col: 7
# row: 4, col: 4
# row: 4, col: 5
# row: 4, col: 6
# row: 4, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# start_val: -4. Inner loop start_col: 5 / end_col: 7
# row: 5, col: 5
# row: 5, col: 6
# row: 5, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# start_val: -5. Inner loop start_col: 6 / end_col: 7
# row: 6, col: 6
# row: 6, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# start_val: -6. Inner loop start_col: 7 / end_col: 7
# row: 7, col: 7
# [0, -1, -2, -3, -4, -5, -6, -8]

# "Answer: -8"