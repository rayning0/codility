def solution(n)
  bin = binary(n) # or n.to_s(2) does direct binary conversion
  zeroes = bin.split('1')
  return 0 if zeroes.empty?
  zeroes.pop unless bin[-1] == '1'
  zeroes.max.length
end

def binary(m)
  bin = ''
  begin
    bin.insert(0, (m % 2).to_s)
    m /= 2
  end until m == 0
  bin
end