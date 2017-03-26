# https://codility.com/demo/results/trainingNW3CQ4-8S7/
# O(sqrt(n)) time. O(1) space.
def solution(n)
  factors = 0
  (1..Math.sqrt(n)).each do |i|
    if n % i == 0
      factors += i == Math.sqrt(n) ? 1 : 2
    end
  end
  factors
end