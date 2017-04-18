
# https://codility.com/demo/results/trainingP4UTRR-JAT/
# Fastest: solution4, Caterpillar method!

# Array is sorted in increasing order. Find number of 
# distinct absolute values in array
a = [-5, -4, -4, -2, 0, 1, 1, 1, 4, 5, 6]
#1. Use Array methods
# O(n) or O(n log n)
def solution1(a)
  a.map(&:abs).uniq.size
end

#2. Use Set
# O(n) or O(n log n)
require 'set'

def solution2(a)
  Set.new(a.map(&:abs)).size
end

#3. Use Hash
# O(n) or O(n log n)
def solution3(a)
  freq = {}
  a.each do |num|
    num = num.abs
    freq[num] ? next : freq[num] = 1
  end
  freq.size
end

#4. Caterpillar method

# We prepare 2 cursors. First ('l') scans array from L to R
# and the other ('r') scans from the R to L.

# If abs(A[l]) > abs(A[r]), we move the left cursor one more step. 
# If abs(A[l]) < abs(A[r]), we move the right cursor one more step. 
# If abs(A[l]) == abs(A[r]), we move both. 

# In any case of the above, we increment the counter,
# since we found an absolute distinct value.

# In all cases, if next step is same character as last one, keep moving cursor.

#a = [-5, -4, -4, -2, 0, 1, 1, 1, 4, 5, 6]
# O(N) or O(N*log(N))
def solution4(a)
  left = 0
  right = a.size - 1
  distinct = 0

  while left <= right
    # puts "left: #{left}, right: #{right}"
    # puts "a[l]: #{a[left]}, a[r]: #{a[right]}"
    # puts "distinct: #{distinct}"
    if a[left].abs > a[right].abs
      begin
        left += 1
      end until a[left] != a[left - 1]
    elsif a[left].abs < a[right].abs
      begin
        right -= 1
      end until a[right] != a[right + 1]
    else
      begin
        left += 1
      end until a[left] != a[left - 1]
      begin
        right -= 1
      end until a[right] != a[right + 1] 
    end

    distinct += 1
  end
  distinct
end

# left: 0, right: 10
# a[l]: -5, a[r]: 6
# distinct: 0
# left: 0, right: 9
# a[l]: -5, a[r]: 5
# distinct: 1
# left: 1, right: 8
# a[l]: -4, a[r]: 4
# distinct: 2
# left: 3, right: 7
# a[l]: -2, a[r]: 1
# distinct: 3
# left: 4, right: 7
# a[l]: 0, a[r]: 1
# distinct: 4
# left: 4, right: 4
# a[l]: 0, a[r]: 0
# distinct: 5
# 6

start = Time.now
p solution1(a)
puts "#{Time.now - start} secs"
start = Time.now
p solution2(a)
puts "#{Time.now - start} secs"
start = Time.now
p solution3(a)
puts "#{Time.now - start} secs"
start = Time.now
p solution4(a)
puts "#{Time.now - start} secs"

# Fastest: solution4, Caterpillar method!
# 1) 4.8e-05 secs
# 2) 3.4e-05 secs
# 3) 1.6e-05 secs
# 4) 1.5e-05 secs
