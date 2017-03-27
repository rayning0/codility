# https://codility.com/demo/results/trainingY67YP5-4QB/
# require 'minitest/autorun' <--- for Minitest

# O(n*n). 100% correct, 20% performance.
def slow_solution(a)
  return 0 if [1, 2].include?(a.size)
  peaks = []
  blocks = 0
  length = a.size

  (1..length - 2).each do |i|
    if a[i] > a[i - 1] && a[i] > a[i + 1]
      peaks << i
    end
  end

  peaks.size.downto(1) do |b|
    next unless length % b == 0
    num_peaks = 0
    bsize = length / b
    b.times do |c|
      if !peaks.any? {|p| p.between?(c * bsize, (c+1) * bsize - 1)}
                                    # 0        ..1 * bsize - 1
                                    # 1 * bsize..2 * bsize - 1
                                    # 2 * bsize..3 * bsize - 1
        break
      else
        num_peaks += 1
      end
    end
    return b if num_peaks == b
  end
  blocks
end

# O(n*log(log n)) time. O(n) space.
def fast_solution(a)
  peaks = []
  blocks = 0
  length = a.size

  # find indices of all peaks
  (1..length - 2).each do |i|
    if a[i] > a[i - 1] && a[i] > a[i + 1]
      peaks << i
    end
  end

  # max possible # of blocks = # of peaks
  peaks.size.downto(1) do |blocks|
    next unless length % blocks == 0
    block_size = length / blocks
    block_no = 0


    peaks.each do |peak|
      if peak / block_size > block_no
        # current block doesn't have peak. try smaller # of blocks.
        break
      end
      if peak / block_size == block_no
        # current block has peak. see if next block has peak.
        block_no += 1
      end
    end

    return blocks if block_no == blocks
  end
end

# RSpec tests:

describe '#solution' do
  it 'finds max # of blocks into which array may be divided' do
    expect(solution([5, 6])).to eq(0)
    expect(solution([4, 6, 2])).to eq(1)
    expect(solution([1, 10, 9, 6, 20])).to eq(1)
    expect(solution([1, 2, 1, 2, 1, 2])).to eq(2)
    expect(solution([1, 2, 3, 4, 3, 4, 1, 2, 3, 4, 6, 2])).to eq(3)
    expect(solution([1, 5, 3, 4, 3, 4, 1, 0, 1, 4, 6, 7])).to eq(1)
    expect(solution([1, 5, 3, 4, 3, 4, 1, 2, 1, 4, 6, 7])).to eq(2)
  end
end

# Minitest style:

# class TestPeaks < Minitest::Test
#   def test_peaks
#     assert_equal(0, solution([5, 6]))
#   end
# end

# Your test case:  [5, 6]
# Returned value: 0

# Your test case:  [4, 6, 2]
# Returned value: 1
# peaks = [1]

# Your test case:  [1, 10, 9, 6, 20]
# Returned value: 1
# peaks = [1]

# Your test case:  [1, 2, 1, 2, 1, 2]
# Returned value: 2
# peaks = [1, 3]

# Example test:    [1, 2, 3, 4, 3, 4, 1, 2, 3, 4, 6, 2]
# Returned value: 3
# Peaks = [3, 5, 10]

# Your test case:    [1, 5, 3, 4, 3, 4, 1, 0, 1, 4, 6, 7]
# Returned value: 1
# peaks = [1, 3, 5]

# Your test case:    [1, 5, 3, 4, 3, 4, 1, 2, 1, 4, 6, 7]
# Returned value: 2
# peaks = [1, 3, 5, 7]