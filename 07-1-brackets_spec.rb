# https://app.codility.com/demo/results/trainingJW3BU4-E8H/

def solution(s)
  stack = []
  hash = {'{' => '}', '(' => ')', '[' => ']'}
  s.each_char do |char|
    if hash[stack.last] == char
      stack.pop
    else
      stack << char
    end
  end

  return 0 if stack.size > 0
  1
end

# Golang version:
# https://www.hackerrank.com/challenges/balanced-brackets/problem

# func isBalanced(s string) string {
#     stack := []string{}
#     hash := map[string]string{
#         "(": ")",
#         "[": "]",
#         "{": "}",
#     }
#     var top string

#     for _, char := range strings.Split(s, "") {
#         if len(stack) > 0 {
#             top = stack[len(stack)-1]
#         } else {
#             top = ""
#         }
#         if hash[top] == char {
#             stack = stack[:len(stack)-1] // pop off stack
#         } else {
#             stack = append(stack, char)
#         }
#     }
#     if len(stack) > 0 {
#         return "NO"
#     }
#     return "YES"
# }

describe '#brackets' do
  it 'returns 1 if brackets are properly nested' do
    expect(solution("{[()()]}")).to eq 1
  end

  it 'returns 0 if they are not' do
    expect(solution("([)()]")).to eq 0
  end
end

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
