# https://codility.com/demo/results/trainingSHP35R-NYT/

def solution(s)
  return 1 if s == ''
  right_brackets = ['}', ']', ')']
  return 0 if right_brackets.include?(s[0])
  brackets = {'{' => '}', '[' => ']', '(' => ')'}
  stack = []
  s.split('').each do |char|
    puts "char = #{char}"
    if brackets[stack.last] == char
      puts "pop #{stack.last} #{char}"
      stack.pop
    else
      stack << char
    end
    puts "stack: #{stack}"
  end
  puts "final stack: #{stack}"
  if stack.size > 0
    0
  else
    1
  end
end

p solution("{[()()]}")
p solution("([)()]")

# char = {
# stack: ["{"]
# char = [
# stack: ["{", "["]
# char = (
# stack: ["{", "[", "("]
# char = )
# pop ( )
# stack: ["{", "["]
# char = (
# stack: ["{", "[", "("]
# char = )
# pop ( )
# stack: ["{", "["]
# char = ]
# pop [ ]
# stack: ["{"]
# char = }
# pop { }
# stack: []
# final stack: []
# 1
# char = (
# stack: ["("]
# char = [
# stack: ["(", "["]
# char = )
# stack: ["(", "[", ")"]
# char = (
# stack: ["(", "[", ")", "("]
# char = )
# pop ( )
# stack: ["(", "[", ")"]
# char = ]
# stack: ["(", "[", ")", "]"]
# final stack: ["(", "[", ")", "]"]
# 0