
# O(n*n*n)
def slow_solution(a)
  sum = 0
  new_array = []
  (0..a.length-3).each do |x|
    (x+1..a.length-2).each do |y|
      (y+1..a.length-1).each do |z|
        puts "x: #{x}, y: #{y}, z: #{z}"
        new_array = a[x+1..y-1] + a[y+1..z-1]
        puts "new_array: #{new_array}"
        sum = [max_slice(new_array), sum].max
        puts "sum: #{sum}"
      end
    end
  end
  sum
end

# puts slow_solution(a)

def max_slice(array)
  max_ending = max_slice_sum = 0
  array.each do |a|
    max_ending = [0, max_ending + a].max
    max_slice_sum = [max_ending, max_slice_sum].max
  end
  max_slice_sum
end

a = [3, 2, 6, -1, 4, 5, -1, 2]
# O(n)
def fast_solution(a)
  left2right = [0] * a.size
  right2left = [0] * a.size
  # make array of max_endings from left to right
  1.upto(a.size - 2) do |i|
    left2right[i] = [0, left2right[i - 1] + a[i]].max
  end

  # make array of max_endings from right to left
  (a.size - 2).downto(1) do |i|
    right2left[i] = [0, right2left[i + 1] + a[i]].max
  end

  max_dbl_sum = 0
  (1..a.size - 2).each do |i|
    # add both to get max_slice
    max_sum = left2right[i - 1] + right2left[i + 1]
    max_dbl_sum = [max_dbl_sum, max_sum].max
  end
  max_dbl_sum
end

p fast_solution(a)

# light2right: [0, 2,   8, 7, 11, 16, 15, 0]
# right2left:  [0, 16, 14, 8, 9, 5, 0, 0]

# Ex: If we slice original array at Y = 2
# maxending from L to R of index 1 = 2
# maxending from R to L of index 3..6 = 8
# max_slice: 2 + 8

# Ex: If we slice original array at Y = 4
# maxending from L to R of index 1..3 = 7
# maxending from R to L of index 5..6 = 5
# max_slice: 7 + 5
