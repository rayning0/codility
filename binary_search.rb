# Binary search. Array must be SORTED.

# recursive
def bsearch_r(a, val)
  i = a.size / 2
  puts "a: #{a}, i: #{i}"
  return -1 if a.empty?
  return val if a[i] == val
  if a[i] < val
    bsearch_r(a[i + 1..-1], val)
  else
    bsearch_r(a[0..i - 1], val)
  end
end

a = [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99]
p bsearch_r(a, 5)
p bsearch_r(a, 99)
p bsearch_r(a, 100)

# iterative
def bsearch_i(a, val)
  min = 0
  max = a.size - 1
  while min <= max
    mid = (min + max) / 2
    puts "mid: #{mid}, min: #{min}, max: #{max}"
    return val if a[mid] == val
    if a[mid] < val
      min = mid + 1
    else
      max = mid - 1
    end
  end
  -1
end

p bsearch_i(a, 5)
p bsearch_i(a, 99)
p bsearch_i(a, 100)

# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [5, 7, 10, 16, 21, 38, 44], i: 3
# a: [5, 7, 10], i: 1
# a: [5], i: 0
# 5
# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [52, 67, 79, 80, 95, 99], i: 3
# a: [95, 99], i: 1
# 99
# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [52, 67, 79, 80, 95, 99], i: 3
# a: [95, 99], i: 1
# a: [], i: 0
# -1

# mid: 6, min: 0, max: 13
# mid: 2, min: 0, max: 5
# mid: 0, min: 0, max: 1
# 5
# mid: 6, min: 0, max: 13
# mid: 10, min: 7, max: 13
# mid: 12, min: 11, max: 13
# mid: 13, min: 13, max: 13
# 99
# mid: 6, min: 0, max: 13
# mid: 10, min: 7, max: 13
# mid: 12, min: 11, max: 13
# mid: 13, min: 13, max: 13
# -1