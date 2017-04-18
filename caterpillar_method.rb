# Move both front and rear ends forwards.
# Move front forward as far as possible, then rear forward 1 step.

# O(n)
# Does a have a contiguous subset whose sum = s?
def caterpillar(a, s)
  front, sum = 0, 0
  n = a.size
  n.times do |back|
    # inch front of caterpillar as many steps as possible
    while front < n && sum + a[front] <= s 
      sum += a[front]
      front += 1
    end
    if sum == s
      puts "back: #{back}, front: #{front}"
      return true 
    end
    sum -= a[back]  # move back of caterpillar forward 1 step
  end
  false
end

a = [6, 2, 7, 4, 1, 3, 6]
p caterpillar(a, 12)
# back: 2, front: 5
# true

# Given n sticks of lengths 1 <= a0 <= a1...<= an-1 <= 10^9),
# count the number of triangles that can be constructed using these sticks.
# We have to count triplets at indices x < y < z, such that ax + ay > az.
# For every pair x, y we can find largest stick z that can be used to construct the triangle.
# Every stick k, such that y < k <= z, can also be used, because the
# ax + ay > ak will still be true. We can add up all these triangles at once.

# O(n * n)
def triangles(a)
  a.sort!
  triangles = 0
  n = a.size
  n.times do |x|
    z = x + 2
    (x + 1..n - 1).each do |y|
      puts "x: #{x}, y: #{y}"
      while z < n && a[x] + a[y] > a[z]
        puts "#{a[x]} + #{a[y]} > #{a[z]}"
        puts "z: #{z}" 
        z += 1
      end
      triangles += z - y - 1
      puts "triangles: #{triangles}"
    end
  end
  triangles
end

a = [10, 2, 5, 1, 8, 12]
p a.sort
p "#{triangles(a)} triangles"
