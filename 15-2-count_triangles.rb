# O(n * n)
def solution(a)
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

# In the line :—
# triangles += z - y – 1

# x is the first item for the triangles.
# y is the the second item for the triangles.
# All the elements between y (exclusive) and z (exclusive) could be the third item for the triangles.

# z – y – 1 is the number of elements in the range (y, z), both excusive.