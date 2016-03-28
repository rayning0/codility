# https://codesays.com/2014/solution-to-triangle-by-codility/

def solution(a)
  return 0 if a.length < 3
  a.sort!

  # After sorting, a[i] < a[i + 1] < a[i + 2]

  # These must be true:
  # a[i+1] + a[i+2] > a[i]
  # a[i] + a[i+2] > a[i+1]

  # Thus all we must check is if
  # a[i] + a[i + 1] > a[i + 2]

  (0..a.length - 3).each do |i|
    return 1 if a[i] + a[i + 1] > a[i + 2]
  end

  # If a[i] + a[i + 1] > a[i + 2], comments below show
  # the original indices P, Q, R should have P < Q < R
  # for at least 1 of those 3 inequalities
  0
end

# a = [10, 2, 5, 1, 8, 20]
# sorted = [1, 2, 5-2, 8-4, 10-0, 20]

# 5 + 8 > 10 => 2, 4, 0
# 10 + 5 > 8 => 0, 2, 4
# 8 + 10 > 5 => 4, 0, 2
# p solution(a)

# a = [10, 50, 5, 1]
# p solution(a)

# n = 4, m = 3, 1
# a[2] + a[2 + 3] > a[2 + 4]

# a[2] <= a[2 + 3 - 1] = a[4] YES!!
# a[2 + 3 + 1] <= a[2 + 4] YES!!!

# a[2 + 3 - 1] + a[2 + 3] >= a[2] + a[2 + 3] > a[2 + 4] >= a[2 + 3 + 1]
# a[4]         + a[5]     >= a[2] + a[5]     > a[6]     >= a[6]

# 1) A[index]+A[index+m] >  A[index+n]
# 2) A[index+m-1]        >= A[index]
# 3) A[index + n]        >= A[index+m+1]

# 1) + 2): A[index+m] + A[index+m-1] >= A[index+n]
# + 3): A[index+m-1] + A[index+m] >=  A[index+m+1]
