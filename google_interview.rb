# My versions of the Google interview problem shown here:
# https://www.youtube.com/watch?v=XKu_SEDAykw

a1 = [1, 2, 3, 9] # SORTED arrays. Could have negatives.
a2 = [1, 2, 4, 4]

# 1. Slow solution, with binary search
# O(n log n)
def has_pair_with_sum(data, sum)
  (0..data.size - 2).each do |i|
    num = data[i]
    complement = sum - num
    puts "num: #{num}, complement: #{complement}"

    # binary search for num's complement in rest of array
    lo = i + 1
    hi = data.size - 1
    while lo <= hi
      mid = (lo + hi) / 2
      puts "data[mid]: #{data[mid]}, mid: #{mid}, lo: #{lo}, hi: #{hi}"
      return true if data[mid] == complement
      if data[mid] < complement
        lo = mid + 1
      else
        hi = mid - 1
      end
    end
  end
  false
end

p has_pair_with_sum(a1, 8)  # false
p has_pair_with_sum(a2, 8)  # true

# num: 1, complement: 7
# data[mid]: 3, mid: 2, lo: 1, hi: 3
# data[mid]: 9, mid: 3, lo: 3, hi: 3
# num: 2, complement: 6
# data[mid]: 3, mid: 2, lo: 2, hi: 3
# data[mid]: 9, mid: 3, lo: 3, hi: 3
# num: 3, complement: 5
# data[mid]: 9, mid: 3, lo: 3, hi: 3
# false

# num: 1, complement: 7
# data[mid]: 4, mid: 2, lo: 1, hi: 3
# data[mid]: 4, mid: 3, lo: 3, hi: 3
# num: 2, complement: 6
# data[mid]: 4, mid: 2, lo: 2, hi: 3
# data[mid]: 4, mid: 3, lo: 3, hi: 3
# num: 4, complement: 4
# data[mid]: 4, mid: 3, lo: 3, hi: 3
# true

# 2. Fast solution, with 2 cursors moving from ends to center
# O(n)
def has_pair_with_sum(data, sum)
  lo = 0
  hi = data.size - 1
  test_sum = data[lo] + data[hi]
  while lo <= hi
    puts "test_sum: #{test_sum}, data[lo]: #{data[lo]}, data[hi]: #{data[hi]}"
    return true if test_sum == sum
    if test_sum > sum
      hi -= 1
    else
      lo += 1
    end
    test_sum = data[lo] + data[hi]
  end
  false
end

p has_pair_with_sum(a1, 8)  # false
p has_pair_with_sum(a2, 8)  # true

# test_sum: 10, data[lo]: 1, data[hi]: 9
# test_sum: 4, data[lo]: 1, data[hi]: 3
# test_sum: 5, data[lo]: 2, data[hi]: 3
# test_sum: 6, data[lo]: 3, data[hi]: 3
# false

# test_sum: 5, data[lo]: 1, data[hi]: 4
# test_sum: 6, data[lo]: 2, data[hi]: 4
# test_sum: 8, data[lo]: 4, data[hi]: 4
# true

a1 = [9, 2, 3, 1] 
a2 = [4, -2, 1, 4] # UNSORTED, with negatives

# 3. Google guy's fast solution, with Set
# http://ruby-doc.org/stdlib-2.4.1/libdoc/set/rdoc/Set.html
# O(n)
require 'set'
def has_pair_with_sum(data, sum)
  complement = Set.new [] 
  data.each do |value|
    # Ruby's Set has O(1) constant time, fast lookup speeds, like Hash
    return true if complement.include?(value)
    complement.add(sum - value)
    p complement
  end
  false
end

p has_pair_with_sum(a1, 8)  # false
p has_pair_with_sum(a2, 8)  # true

#<Set: {-1}>
#<Set: {-1, 6}>
#<Set: {-1, 6, 5}>
#<Set: {-1, 6, 5, 7}>
# false

#<Set: {4}>
#<Set: {4, 10}>
#<Set: {4, 10, 7}>
# true

# The YouTube video has a C++ convention:

# This explains why C++ uses "!= end()" to detect the end of loops,
# plus how to iterate over an "unordered set" (data structure the Google guy chose):
# http://stackoverflow.com/questions/9963401/why-are-standard-iterator-ranges-begin-end-instead-of-begin-end
# http://stackoverflow.com/questions/9087217/how-does-one-iterate-through-an-unordered-set-in-c

# end() is actually an iterator ONE PAST THE END of complement, not the actual end.
# So "if complement.find(value) != complement.end()" from the video means:

# "If the complement set has value in it, plus we haven't gone past the end of the set"

# We obviously don't need this != end() check in Ruby.


# 4. Fast solution with hash
# O(n)
def has_pair_with_sum(data, sum)
  complement = {} # Hash has O(1) constant lookup time.
  data.each do |value|

# Why is Hash lookup in Ruby so fast? This guy recreates a Hash with a custom class,
# then shows how a Ruby Hash puts items in bins.

# https://blog.engineyard.com/2013/hash-lookup-in-ruby-why-is-it-so-fast
# Instead of using single array to store all its entries,
# hashes in Ruby use an array of arrays or “bins”.
# First, it calculates a unique integer value for each entry. Here he uses Object#hash.
# Then, Ruby divides this hash integer by the total number of bins and obtains the remainder or modulus.
# This modulus is used as the bin index for that specific entry.

    return true if complement[value]
    complement[sum - value] = 1
    p complement
  end
  false
end

p has_pair_with_sum(a1, 8)  # false
p has_pair_with_sum(a2, 8)  # true

# {-1=>1}
# {-1=>1, 6=>1}
# {-1=>1, 6=>1, 5=>1}
# {-1=>1, 6=>1, 5=>1, 7=>1}
# false

# {4=>1}
# {4=>1, 10=>1}
# {4=>1, 10=>1, 7=>1}
# true

# 5. Bad solution with array: WON'T work!
# Only works if sum >= value always, impossible for a general integer array
# O(n)
def has_pair_with_sum(data, sum)
  complement = []
  data.each do |value|

    # Array has O(1) constant access time, because:
    # http://stackoverflow.com/questions/7297916/why-does-accessing-an-element-in-an-array-take-constant-time

    # Arrays are stored in memory sequentially. When you access array[3] you are telling the computer,
    # "Get the memory address of the beginning of array, then add 3 to it, then access that spot."
    # Since adding takes constant time, so does array access!

    return true if complement[value]
    complement[sum - value] = 1
    p complement
  end
  false
end
