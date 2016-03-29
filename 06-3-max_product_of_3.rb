# https://codility.com/demo/results/trainingJN2VE5-5Q4/

def solution(a)
  a.sort!
  # max product, after sort, is either prod of last 3 numbers,
  # or prod of first 2 (negative) numbers * last positive number
  [a[-3] * a[-2] * a[-1], a[0] * a[1] * a[-1]].max
end

a = [-3, 1, 2, -2, 5, 6]

p solution(a)