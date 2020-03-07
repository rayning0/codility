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
