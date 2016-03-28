# 3 solutions

require 'set'
def solution(a)
    s = Set.new
    a.each do |num|
        s << num
    end
    s.size
end

# without using Set
def solution(a)
  distinct = a.length == 0 ? 0 : 1
  a.sort!
  (1..a.length - 1).each do |i|
    next if a[i] == a[i - 1]
    distinct += 1
  end
  distinct
end

p solution([2, 1, 1, 2, 3, 1])

# https://codility.com/demo/results/demo855EPB-CXK/
# Time complexity: O(N*log N)
def solution(a)
    h = {}
    a.each do |num|
      h[num] ? h[num] += 1 : h[num] = 1
    end
    h.keys.count
end

p solution([1,3,3,2,1,5,6,4,5])