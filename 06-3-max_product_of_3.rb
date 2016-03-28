def solution(a)
  a.sort!
  len = a.length
  [a[0] * a[1] * a[-1], a[len - 3] * a[len - 2] * a[len - 1]].max
end

a = [-3, 1, 2, -2, 5, 6]

p solution(a)