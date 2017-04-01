def binary(m)
  bin = []
  begin
    bin.unshift(m % 2)
    m /= 2
  end until m == 0
  bin.join
end

def solution(n)
  bin = binary(n) # or n.to_s(2) does direct binary conversion
  zeroes = bin.split('1')
  return 0 if zeroes.empty?
  zeroes.pop unless bin[-1] == '1'
  zeroes.max.length
end

# Convert 25 to binary = ‘11001’

# 25 / 2 = 12
# 25 % 2 = 1 *

# 12 / 2 = 6
# 12 % 2 = 0 *

# 6 / 2 = 3
# 6 % 2 = 0 *

# 3 / 2 = 1
# 3 % 2 = 1 *

# 1 / 2 = 0
# 1 % 2 = 1 *

# Binary number = all mod answers combined backwards!