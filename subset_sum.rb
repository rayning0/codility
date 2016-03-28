 # Take the array of numbers stored in arr and return true if any combination of numbers in the array can add up to equal a certain sum, otherwise return false. For example: if arr contains [4, 6, 10, 1, 3] and sum = 23 the output is true because 4 + 6 + 10 + 3 = 23. The array will not be empty, will not contain all the same elements, and may contain negative numbers.

 # Subset Sum: special case of knapsack problem

 a = [4, 6, 10, 1, 3]

def is_subset_sum?(a, n, sum)
  puts "a: #{a}, n: #{n}, sum: #{sum}"
  return true if sum == 0
  return false if n == 0 && sum > 0
  if a[n - 1] > sum
    return is_subset_sum?(a, n - 1, sum)
  end

  # see if we may get sum from one of these 2 cases:
  # 1. excluding last element (expression on left)
  # 2. including last element (expression on right)

  return is_subset_sum?(a, n - 1, sum - a[n - 1]) || is_subset_sum?(a, n - 1, sum)
end

p is_subset_sum?(a, a.length, 23)