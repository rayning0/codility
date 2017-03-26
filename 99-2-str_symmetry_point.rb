# https://codility.com/demo/results/trainingUAWWWW-JMP/

def solution(s)
  length = s.length
  return 0 if length == 1
  return -1 if s != s.reverse
  # answer is just middle index of a palindrome
  length.odd? ? length / 2 : -1
end