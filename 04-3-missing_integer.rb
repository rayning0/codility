# https://codility.com/demo/results/demoKZNNAB-Q6B/
require 'rspec/autorun'

def solution1(a)
    n = a.length
    counts = Array.new(n + 1, 0)
    a.each do |num|
        counts[num] = 1 if num.between?(1, n + 1)
    end

    counts.length.times do |count|
      next_count = count + 1
      return next_count if counts[next_count] == 0
    end
    n + 1
end


# For answer, just care about first n positive integers.
# Ignore any numbers < 1 or > n.

def solution(a)
  n = a.size
  saw = Array.new(n)

  n.times do |i|
    if a[i].between?(1, n)
      saw[a[i] - 1] = 1
    end
  end

  saw.size.times do |anum|
    return anum + 1 if saw[anum].nil?
  end

  n + 1
end

describe 'Missing Integer' do
  it 'Finds smallest positive integer that does not occur in a given sequence.' do
    expect(solution([5])).to eq 1
    expect(solution([-1000000, 1000000])).to eq 1
    expect(solution([1, 1, 1])).to eq 2
    expect(solution([3, 3, 3])).to eq 1
    expect(solution([-1, -3])).to eq 1
    expect(solution([1, 2, 3])).to eq 4
    expect(solution([1, 3, 6, 4, 1, 2])).to eq 5
    expect(solution([6, 5, 3, 2, 1])).to eq 4
  end
end
