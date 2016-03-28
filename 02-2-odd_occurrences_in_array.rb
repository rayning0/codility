def solution(a)
  h = {}
  a.each do |num|
    h[num] ? h.delete(num) : h[num] = 1
  end
  h.key(1)
end

puts solution([3, 5, 3, 7, 5, 10, 10, 3, 10, 3, 10])