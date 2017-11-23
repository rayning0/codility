# https://codility.com/demo/results/trainingHJERD9-VU2/
require 'rspec/autorun'

def solution(a, b)
  len = a.size
  return len if len <= 1
  count = 1
  right_end = b[0]
  (1..len - 1).each do |i|
    next if a[i] <= right_end
    count += 1
    right_end = b[i]
  end
  count
end

describe 'Max Nonoverlapping Segments' do
  it 'finds size of non-overlapping set w/ max number of segments' do
    a, b = [], []
    expect(solution(a, b)).to eq 0
    a, b = [2], [5]
    expect(solution(a, b)).to eq 1
    a, b = [2, 4], [5, 10]
    expect(solution(a, b)).to eq 1
    a, b = [2, 5], [5, 10]
    expect(solution(a, b)).to eq 1
    a, b = [2, 5], [4, 10]
    expect(solution(a, b)).to eq 2
    a = [1, 3, 7, 9, 9]
    b = [5, 6, 8, 9, 10]
    expect(solution(a, b)).to eq 3
  end
end
