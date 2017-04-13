 # Take array and return result if any combo of numbers in array add up to a certain sum, else return false. Example: if arr contains [4, 6, 10, 1, 3] and sum = 23,  output = [4, 6, 10, 3] since 4 + 6 + 10 + 3 = 23. The array will not be empty, will not contain all the same elements, and may contain negative numbers.

 # Subset Sum: special case of knapsack problem

 # https://livinglifetechway.com/solving-subset-sum-problem/
 # http://www.skorks.com/2011/02/algorithms-a-dropbox-challenge-and-dynamic-programming/
 # https://www.youtube.com/watch?v=zKwwjAkaXLI

a = [4, 6, 10, 1, 3]
require 'pry'
require 'rspec/autorun'

# Recursive: Works for ALL POSITIVE numbers:
def subset_sum1(a, sum, result = [])
  #puts "a: #{a}, sum: #{sum}, result: #{result}"
  return result if sum == 0 # found answer
  if sum < 0 || a.size == 0
    result.pop
    return false
  end
  subset_sum1(a[1..-1], sum - a[0], result << a[0]) || # try next element
  subset_sum1(a[1..-1], sum, result)                   # reject next element
end

# p subset_sum1(a, 23)

# a: [4, 6, 10, 1, 3], sum: 23, result: []
# a: [6, 10, 1, 3], sum: 19, result: [4]
# a: [10, 1, 3], sum: 13, result: [4, 6]
# a: [1, 3], sum: 3, result: [4, 6, 10]
# a: [3], sum: 2, result: [4, 6, 10, 1]
# a: [], sum: -1, result: [4, 6, 10, 1, 3]
# a: [], sum: 2, result: [4, 6, 10, 1]
# a: [3], sum: 3, result: [4, 6, 10]
# a: [], sum: 0, result: [4, 6, 10, 3]
# [4, 6, 10, 3]

# p subset_sum1(a, 22)

# a: [4, 6, 10, 1, 3], sum: 22, result: []
# a: [6, 10, 1, 3], sum: 18, result: [4]
# a: [10, 1, 3], sum: 12, result: [4, 6]
# a: [1, 3], sum: 2, result: [4, 6, 10]
# a: [3], sum: 1, result: [4, 6, 10, 1]
# a: [], sum: -2, result: [4, 6, 10, 1, 3]
# a: [], sum: 1, result: [4, 6, 10, 1]
# a: [3], sum: 2, result: [4, 6, 10]
# a: [], sum: -1, result: [4, 6, 10, 3]
# a: [], sum: 2, result: [4, 6, 10]
# a: [1, 3], sum: 12, result: [4, 6]
# a: [3], sum: 11, result: [4, 6, 1]
# a: [], sum: 8, result: [4, 6, 1, 3]
# a: [], sum: 11, result: [4, 6, 1]
# a: [3], sum: 12, result: [4, 6]
# a: [], sum: 9, result: [4, 6, 3]
# a: [], sum: 12, result: [4, 6]
# a: [10, 1, 3], sum: 18, result: [4]
# a: [1, 3], sum: 8, result: [4, 10]
# a: [3], sum: 7, result: [4, 10, 1]
# a: [], sum: 4, result: [4, 10, 1, 3]
# a: [], sum: 7, result: [4, 10, 1]
# a: [3], sum: 8, result: [4, 10]
# a: [], sum: 5, result: [4, 10, 3]
# a: [], sum: 8, result: [4, 10]
# a: [1, 3], sum: 18, result: [4]
# a: [3], sum: 17, result: [4, 1]
# a: [], sum: 14, result: [4, 1, 3]
# a: [], sum: 17, result: [4, 1]
# a: [3], sum: 18, result: [4]
# a: [], sum: 15, result: [4, 3]
# a: [], sum: 18, result: [4]
# a: [6, 10, 1, 3], sum: 22, result: []
# a: [10, 1, 3], sum: 16, result: [6]
# a: [1, 3], sum: 6, result: [6, 10]
# a: [3], sum: 5, result: [6, 10, 1]
# a: [], sum: 2, result: [6, 10, 1, 3]
# a: [], sum: 5, result: [6, 10, 1]
# a: [3], sum: 6, result: [6, 10]
# a: [], sum: 3, result: [6, 10, 3]
# a: [], sum: 6, result: [6, 10]
# a: [1, 3], sum: 16, result: [6]
# a: [3], sum: 15, result: [6, 1]
# a: [], sum: 12, result: [6, 1, 3]
# a: [], sum: 15, result: [6, 1]
# a: [3], sum: 16, result: [6]
# a: [], sum: 13, result: [6, 3]
# a: [], sum: 16, result: [6]
# a: [10, 1, 3], sum: 22, result: []
# a: [1, 3], sum: 12, result: [10]
# a: [3], sum: 11, result: [10, 1]
# a: [], sum: 8, result: [10, 1, 3]
# a: [], sum: 11, result: [10, 1]
# a: [3], sum: 12, result: [10]
# a: [], sum: 9, result: [10, 3]
# a: [], sum: 12, result: [10]
# a: [1, 3], sum: 22, result: []
# a: [3], sum: 21, result: [1]
# a: [], sum: 18, result: [1, 3]
# a: [], sum: 21, result: [1]
# a: [3], sum: 22, result: []
# a: [], sum: 19, result: [3]
# a: [], sum: 22, result: []
# false

# Recursive: Works for positive AND negative numbers
def subset_sum2(a, sum, result = [])
  # puts "a: #{a}, sum: #{sum}, result: #{result}"
  return result if sum == 0 # got answer
  if a.size == 0
    result.pop
    return false
  end
  subset_sum2(a[1..-1], sum - a[0], result << a[0]) || # try next element
  subset_sum2(a[1..-1], sum, result)                   # reject next element
end

#p subset_sum2(a, -11)

# a: [4, 6, -9, 1, -3], sum: -11, result: []
# a: [6, -9, 1, -3], sum: -15, result: [4]
# a: [-9, 1, -3], sum: -21, result: [4, 6]
# a: [1, -3], sum: -12, result: [4, 6, -9]
# a: [-3], sum: -13, result: [4, 6, -9, 1]
# a: [], sum: -10, result: [4, 6, -9, 1, -3]
# a: [], sum: -13, result: [4, 6, -9, 1]
# a: [-3], sum: -12, result: [4, 6, -9]
# a: [], sum: -9, result: [4, 6, -9, -3]
# a: [], sum: -12, result: [4, 6, -9]
# a: [1, -3], sum: -21, result: [4, 6]
# a: [-3], sum: -22, result: [4, 6, 1]
# a: [], sum: -19, result: [4, 6, 1, -3]
# a: [], sum: -22, result: [4, 6, 1]
# a: [-3], sum: -21, result: [4, 6]
# a: [], sum: -18, result: [4, 6, -3]
# a: [], sum: -21, result: [4, 6]
# a: [-9, 1, -3], sum: -15, result: [4]
# a: [1, -3], sum: -6, result: [4, -9]
# a: [-3], sum: -7, result: [4, -9, 1]
# a: [], sum: -4, result: [4, -9, 1, -3]
# a: [], sum: -7, result: [4, -9, 1]
# a: [-3], sum: -6, result: [4, -9]
# a: [], sum: -3, result: [4, -9, -3]
# a: [], sum: -6, result: [4, -9]
# a: [1, -3], sum: -15, result: [4]
# a: [-3], sum: -16, result: [4, 1]
# a: [], sum: -13, result: [4, 1, -3]
# a: [], sum: -16, result: [4, 1]
# a: [-3], sum: -15, result: [4]
# a: [], sum: -12, result: [4, -3]
# a: [], sum: -15, result: [4]
# a: [6, -9, 1, -3], sum: -11, result: []
# a: [-9, 1, -3], sum: -17, result: [6]
# a: [1, -3], sum: -8, result: [6, -9]
# a: [-3], sum: -9, result: [6, -9, 1]
# a: [], sum: -6, result: [6, -9, 1, -3]
# a: [], sum: -9, result: [6, -9, 1]
# a: [-3], sum: -8, result: [6, -9]
# a: [], sum: -5, result: [6, -9, -3]
# a: [], sum: -8, result: [6, -9]
# a: [1, -3], sum: -17, result: [6]
# a: [-3], sum: -18, result: [6, 1]
# a: [], sum: -15, result: [6, 1, -3]
# a: [], sum: -18, result: [6, 1]
# a: [-3], sum: -17, result: [6]
# a: [], sum: -14, result: [6, -3]
# a: [], sum: -17, result: [6]
# a: [-9, 1, -3], sum: -11, result: []
# a: [1, -3], sum: -2, result: [-9]
# a: [-3], sum: -3, result: [-9, 1]
# a: [], sum: 0, result: [-9, 1, -3]
# [-9, 1, -3]

#p subset_sum2(a, 12)

# a: [4, 6, -9, 1, -3], sum: 12, result: []
# a: [6, -9, 1, -3], sum: 8, result: [4]
# a: [-9, 1, -3], sum: 2, result: [4, 6]
# a: [1, -3], sum: 11, result: [4, 6, -9]
# a: [-3], sum: 10, result: [4, 6, -9, 1]
# a: [], sum: 13, result: [4, 6, -9, 1, -3]
# a: [], sum: 10, result: [4, 6, -9, 1]
# a: [-3], sum: 11, result: [4, 6, -9]
# a: [], sum: 14, result: [4, 6, -9, -3]
# a: [], sum: 11, result: [4, 6, -9]
# a: [1, -3], sum: 2, result: [4, 6]
# a: [-3], sum: 1, result: [4, 6, 1]
# a: [], sum: 4, result: [4, 6, 1, -3]
# a: [], sum: 1, result: [4, 6, 1]
# a: [-3], sum: 2, result: [4, 6]
# a: [], sum: 5, result: [4, 6, -3]
# a: [], sum: 2, result: [4, 6]
# a: [-9, 1, -3], sum: 8, result: [4]
# a: [1, -3], sum: 17, result: [4, -9]
# a: [-3], sum: 16, result: [4, -9, 1]
# a: [], sum: 19, result: [4, -9, 1, -3]
# a: [], sum: 16, result: [4, -9, 1]
# a: [-3], sum: 17, result: [4, -9]
# a: [], sum: 20, result: [4, -9, -3]
# a: [], sum: 17, result: [4, -9]
# a: [1, -3], sum: 8, result: [4]
# a: [-3], sum: 7, result: [4, 1]
# a: [], sum: 10, result: [4, 1, -3]
# a: [], sum: 7, result: [4, 1]
# a: [-3], sum: 8, result: [4]
# a: [], sum: 11, result: [4, -3]
# a: [], sum: 8, result: [4]
# a: [6, -9, 1, -3], sum: 12, result: []
# a: [-9, 1, -3], sum: 6, result: [6]
# a: [1, -3], sum: 15, result: [6, -9]
# a: [-3], sum: 14, result: [6, -9, 1]
# a: [], sum: 17, result: [6, -9, 1, -3]
# a: [], sum: 14, result: [6, -9, 1]
# a: [-3], sum: 15, result: [6, -9]
# a: [], sum: 18, result: [6, -9, -3]
# a: [], sum: 15, result: [6, -9]
# a: [1, -3], sum: 6, result: [6]
# a: [-3], sum: 5, result: [6, 1]
# a: [], sum: 8, result: [6, 1, -3]
# a: [], sum: 5, result: [6, 1]
# a: [-3], sum: 6, result: [6]
# a: [], sum: 9, result: [6, -3]
# a: [], sum: 6, result: [6]
# a: [-9, 1, -3], sum: 12, result: []
# a: [1, -3], sum: 21, result: [-9]
# a: [-3], sum: 20, result: [-9, 1]
# a: [], sum: 23, result: [-9, 1, -3]
# a: [], sum: 20, result: [-9, 1]
# a: [-3], sum: 21, result: [-9]
# a: [], sum: 24, result: [-9, -3]
# a: [], sum: 21, result: [-9]
# a: [1, -3], sum: 12, result: []
# a: [-3], sum: 11, result: [1]
# a: [], sum: 14, result: [1, -3]
# a: [], sum: 11, result: [1]
# a: [-3], sum: 12, result: []
# a: [], sum: 15, result: [-3]
# a: [], sum: 12, result: []
# false

# Dynamic Programming, assuming all POSITIVE numbers
def subset_sum_dp1(a, sum)
  result = []
  max_sum = a.sum
  return [] if a.size == 0 || !sum.between?(0, max_sum) || sum == 0
  width = [a.max, sum].max + 1

  m = Array.new(a.size) { Array.new(width, 0) }

  a.size.times do |row|
    # Fill col 1, since we get 0 sum for all numbers by excluding them all
    m[row][0] = 1
  end

  m[0][a[0]] = 1 # Fill row 1. Put 1 (True) at index of first element.

  (1..a.size - 1).each do |row|
    (1..sum).each do |col|

      # use | (bit operator OR) to compare 0 and 1
      m_up_left = if col - a[row] >= 0
                    m[row - 1][col - a[row]]
                  else
                    0
                  end
      m[row][col] = m[row - 1][col] | m_up_left
    end
  end
  puts "a: #{a}. max_sum: #{max_sum}. Can we sum to #{sum}?"
  p (0..width - 1).to_a # print col numbers
  pp m                  # print final matrix

  row = a.size - 1
  col = sum

  if m[row][col] == 0  # did not find subset sum
    puts 'No'
    return []
  end

  # Build sum result array from final matrix
  while row >= 0 && col >= 0
    # puts "row:#{row}, col:#{col}"
    if m[row][col] == 1
      if row == 0 && col > 0
        result << a[0]
        break
      end

      (row - 1).downto(0).each do |r|
        # puts "r: #{r}, m[#{r}][#{col}]: #{m[r][col]}"
        if m[r][col] == 0
          result << a[r + 1]
          row = r
          break
        end

        if r == 0 && col > 0 && m[r][col] == 1
          result << a[0]
          row = r
        end
      end

      col -= a[row + 1]
    else
      break
    end
  end
  p result
  result
end

# a: [4, 6, 10, 1, 3]. max_sum: 24. Can we sum to 22?
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
# [[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
#  [1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0],
#  [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0]]
# No

# a: [4, 6, 10, 1, 3]. max_sum: 24. Can we sum to 23?
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
# [[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0],
#  [1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0],
#  [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1]]
# [3, 10, 6, 4]

# a: [4, 6, 10, 1, 3]. max_sum: 24. Can we sum to 24?
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
# [[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0],
#  [1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0],
#  [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1]]
# [3, 1, 10, 6, 4]

# Dynamic Programming, for positive AND negative numbers
def subset_sum_dp2(a, sum)
  if a.size == 1
    return sum == a.first ? a : []
  end

  min_sum, max_sum = 0, 0
  a.each do |num|
    if num > 0
      max_sum += num
    else
      min_sum += num
    end
  end

  return [] if a.size == 0 || !sum.between?(min_sum, max_sum) || sum == 0

  # map min_sum => 0, max_sum => max_sum - min_sum
  # sum => sum - min_sum

  result = []

  width = max_sum - min_sum + 1
  min_num = a[1..-1].min
  if a.size > 1 && min_num < 0
    width -= min_num  # expands width of 2D matrix for negative numbers
  end

  m = Array.new(a.size) { Array.new(width, 0) }

  if 0.between?(min_sum, max_sum)
    a.size.times do |row|
      # Fill 0 col, since we get 0 sum for all numbers by excluding them all
      m[row][-min_sum] = 1
    end
  end

  m[0][a[0] - min_sum] = 1 # Fill row 1. Put 1 (True) at index of first element.

  (1..a.size - 1).each do |row|
    (0..max_sum - min_sum).each do |col|

      # use | (bit operator OR) to compare 0 and 1
      m_up = if col - a[row] >= 0
               m[row - 1][col - a[row]]
             else
               0
             end
      m[row][col] = m[row - 1][col] | m_up
    end
  end
  puts "a: #{a}. max_sum: #{max_sum}. Can we sum to #{sum}?"
  if sum == -12
    p (0..width - 1).to_a # print col numbers
    p (min_sum..max_sum).to_a # actual col numbers
    #pp m                # print final matrix
  end

  row = a.size - 1
  col = sum - min_sum

  if m[row][col] == 0  # did not find subset sum
    puts 'No'
    return []
  end

  # Build sum result array from final matrix
  while row >= 0 && col >= 0
    if m[row][col] == 1
      if row == 0 && col != -min_sum
        result << a[0]
        break
      end

      (row - 1).downto(0).each do |r|
        if m[r][col] == 0
          result << a[r + 1]
          row = r
          break
        end

        if r == 0 && col != -min_sum && m[r][col] == 1
          result << a[0]
          row = r
        end
      end

      col -= a[row + 1]
    else
      break
    end
  end
  p result
  result
end

# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -12?
# [-3, -9]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -11?
# [-3, 1, -9]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -9?
# [-9]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -8?
# [1, -9]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -7?
# [-3, 1, -9, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -6?
# [-3, -9, 6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -5?
# [-9, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -4?
# [1, -9, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -3?
# [-9, 6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -2?
# [1, -9, 6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to -1?
# [-3, 1, -9, 6, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 1?
# [-9, 6, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 2?
# [1, -9, 6, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 3?
# [-3, 6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 4?
# [4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 5?
# [1, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 6?
# [6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 7?
# [1, 6]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 8?
# [-3, 1, 6, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 10?
# [6, 4]
# a: [4, 6, -9, 1, -3]. max_sum: 11. Can we sum to 11?
# [1, 6, 4]

# ALL TESTS PASS!
describe 'Subset Sum' do
  let(:a) { [4, 6, 10, 1, 3] }
  let(:b) { [4, 6, -9, 1, -3] }
  let(:no_subset_a) { [0, 2, 12, 22] }
  let(:no_subset_b) { [-10, 9] }

  describe '#subset_sum_dp' do
    describe 'finds no subset sum answers' do
      it 'if array all positive' do
        no_subset_a.each do |sum|
          expect(subset_sum_dp1(a, sum)).to eq []
          expect(subset_sum1(a, sum)).to eq([]).or eq false
          expect(subset_sum2(a, sum)).to eq([]).or eq false
        end
      end

      it 'if array includes negatives' do
        no_subset_b.each do |sum|
          expect(subset_sum2(b, sum)).to eq([]).or eq false
          expect(subset_sum_dp2(b, sum)).to eq([]).or eq false
        end
      end
    end

    describe 'finds subset sum answers' do
      it 'if array all positive' do
        (a.sum + 1).times do |s|
          unless no_subset_a.include?(s)
            expect(subset_sum_dp1(a, s).sum).to eq s
            expect(subset_sum1(a, s).sum).to eq s
            expect(subset_sum2(a, s).sum).to eq s
          end
        end
      end

      it 'if array includes negatives' do
        (-12..11).each do |s|
          unless no_subset_b.include?(s)
            expect(subset_sum2(b, s).sum).to eq s
            expect(subset_sum_dp2(b, s).sum).to eq s
          end
        end
      end
    end
  end
end
