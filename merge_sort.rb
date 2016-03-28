a = [15, 8, 4, 12, 4, 3, 8, 15, 10, 6, 2, -1, 0]

def merge_sort(a)
  return a if a.length <= 1
  middle = a.length / 2
  left = a[0..middle - 1]
  right = a[middle..-1]
  puts "left: #{left}, right: #{right}"
  left = merge_sort(left)
  right = merge_sort(right)
  merge(left, right)
end

def merge(left, right)
  result = []
  while left.size > 0 && right.size > 0
    if left.first < right.first
      result << left.shift
    else
      result << right.shift
    end
    p result
  end

  if left.empty?
    result += right
  else
    result += left
  end
  result
end

p merge_sort(a)

# 'left: [15, 8, 4, 12, 4, 3], right: [8, 15, 10, 6, 2, -1, 0]
# left: [15, 8, 4], right: [12, 4, 3]
# left: [15], right: [8, 4]
# left: [8], right: [4]
# [4]
# [4]
# [4, 8]
# left: [12], right: [4, 3]
# left: [4], right: [3]
# [3]
# [3]
# [3, 4]
# [3]
# [3, 4]
# [3, 4, 4]
# [3, 4, 4, 8]
# [3, 4, 4, 8, 12]
# left: [8, 15, 10], right: [6, 2, -1, 0]
# left: [8], right: [15, 10]
# left: [15], right: [10]
# [10]
# [8]
# left: [6, 2], right: [-1, 0]
# left: [6], right: [2]
# [2]
# left: [-1], right: [0]
# [-1]
# [-1]
# [-1, 0]
# [-1]
# [-1, 0]
# [-1, 0, 2]
# [-1, 0, 2, 6]
# [-1]
# [-1, 0]
# [-1, 0, 2]
# [-1, 0, 2, 3]
# [-1, 0, 2, 3, 4]
# [-1, 0, 2, 3, 4, 4]
# [-1, 0, 2, 3, 4, 4, 6]
# [-1, 0, 2, 3, 4, 4, 6, 8]
# [-1, 0, 2, 3, 4, 4, 6, 8, 8]
# [-1, 0, 2, 3, 4, 4, 6, 8, 8, 10]
# [-1, 0, 2, 3, 4, 4, 6, 8, 8, 10, 12]
# [-1, 0, 2, 3, 4, 4, 6, 8, 8, 10, 12, 15]
# [-1, 0, 2, 3, 4, 4, 6, 8, 8, 10, 12, 15, 15]'