# MinAbsSum: https://app.codility.com/programmers/lessons/17-dynamic_programming/min_abs_sum/
# Solution:  https://codility.com/media/train/solution-min-abs-sum.pdf

# if either 1 or -1 is valid, pick -1

# [1]               -1
# [1, 5]            -1    1

# [1, 5, 2]         -1    1
# [1, 5, 2, -2]

# O(n * n * m), where n = a.size, m = max value of a. Remember maxsum = O(n * m)
def slow_solution(a)
  m = 0
  a.size.times do |i|
    a[i] = a[i].abs
    m = [a[i], m].max
  end
  maxsum = a.sum # sum of absolute val of all nums in array
  # maxsum = a.map(&:abs).sum <- Ruby shortcut

  # If dp = 1 at an index, it means some combo of elements in a add up to that index
  dp = [0] * (maxsum + 1)
  dp[0] = 1

  a.size.times do |j|
    maxsum.downto(0).each do |possible_sum|
      puts "a[j]: #{a[j]}, possible sum: #{possible_sum}"
      if (dp[possible_sum] == 1) and (possible_sum + a[j] <= maxsum)

        # if possible_sum + new element a[j] is possible sum, dp = 1!
        dp[possible_sum + a[j]] = 1
        puts "Mark #{possible_sum + a[j]} as possible sum in dp"
      end
    end
    puts "row: #{j}, a[j]: #{a[j]}, dp: #{dp}"
    puts
  end

  min_q_minus_p = maxsum

  # Divide array a into 2 parts, where P = sum of part 1 and Q = sum of part 2,
  # P + Q = maxsum, and P <= maxsum / 2 <= Q.
  # We want largest possible P to get smallest possible Q-P.

  # loop from 0 to maxsum / 2, covering every possible P, Q division
  (maxsum / 2 + 1).times do |possible_half_sum|
    # puts "possible_half_sum: #{possible_half_sum}"
    if dp[possible_half_sum] == 1 # means P or Q = possible_half_sum
      q_minus_p = maxsum - 2 * possible_half_sum
      # puts "Q - P: #{q_minus_p}"
      min_q_minus_p = [min_q_minus_p, q_minus_p].min
      # puts "min Q - P: #{min_q_minus_p}"
    end
  end

  min_q_minus_p
end

describe '#slow_solution' do
  it 'tests something' do
    expect(slow_solution([])).to eq 0
    expect(slow_solution([1, 5, 2, -2])).to eq 0
    expect(slow_solution([-100, -100, -50, -20, -25])).to eq 5
    expect(slow_solution([100, 100, 50, 20, 25])).to eq 5
    expect(slow_solution([0, 0, 0])).to eq 0
    expect(slow_solution([3, 3, 3, 4, 5])).to eq 0
  end
end

# For a = [1, 5, 2, -2]:

# a[j]: 1, possible sum: 10
# a[j]: 1, possible sum: 9
# a[j]: 1, possible sum: 8
# a[j]: 1, possible sum: 7
# a[j]: 1, possible sum: 6
# a[j]: 1, possible sum: 5
# a[j]: 1, possible sum: 4
# a[j]: 1, possible sum: 3
# a[j]: 1, possible sum: 2
# a[j]: 1, possible sum: 1
# a[j]: 1, possible sum: 0
# Mark 1 as possible sum in dp
# row: 0, a[j]: 1, dp: [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# a[j]: 5, possible sum: 10
# a[j]: 5, possible sum: 9
# a[j]: 5, possible sum: 8
# a[j]: 5, possible sum: 7
# a[j]: 5, possible sum: 6
# a[j]: 5, possible sum: 5
# a[j]: 5, possible sum: 4
# a[j]: 5, possible sum: 3
# a[j]: 5, possible sum: 2
# a[j]: 5, possible sum: 1
# Mark 6 as possible sum in dp
# a[j]: 5, possible sum: 0
# Mark 5 as possible sum in dp
# row: 1, a[j]: 5, dp: [1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0]

# a[j]: 2, possible sum: 10
# a[j]: 2, possible sum: 9
# a[j]: 2, possible sum: 8
# a[j]: 2, possible sum: 7
# a[j]: 2, possible sum: 6
# Mark 8 as possible sum in dp
# a[j]: 2, possible sum: 5
# Mark 7 as possible sum in dp
# a[j]: 2, possible sum: 4
# a[j]: 2, possible sum: 3
# a[j]: 2, possible sum: 2
# a[j]: 2, possible sum: 1
# Mark 3 as possible sum in dp
# a[j]: 2, possible sum: 0
# Mark 2 as possible sum in dp
# row: 2, a[j]: 2, dp: [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0]

# a[j]: 2, possible sum: 10
# a[j]: 2, possible sum: 9
# a[j]: 2, possible sum: 8
# Mark 10 as possible sum in dp
# a[j]: 2, possible sum: 7
# Mark 9 as possible sum in dp
# a[j]: 2, possible sum: 6
# Mark 8 as possible sum in dp
# a[j]: 2, possible sum: 5
# Mark 7 as possible sum in dp
# a[j]: 2, possible sum: 4
# a[j]: 2, possible sum: 3
# Mark 5 as possible sum in dp
# a[j]: 2, possible sum: 2
# Mark 4 as possible sum in dp
# a[j]: 2, possible sum: 1
# Mark 3 as possible sum in dp
# a[j]: 2, possible sum: 0
# Mark 2 as possible sum in dp
# row: 3, a[j]: 2, dp: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# possible_half_sum: 0
# Q - P: 10
# min Q - P: 10
# possible_half_sum: 1
# Q - P: 8
# min Q - P: 8
# possible_half_sum: 2
# Q - P: 6
# min Q - P: 6
# possible_half_sum: 3
# Q - P: 4
# min Q - P: 4
# possible_half_sum: 4
# Q - P: 2
# min Q - P: 2
# possible_half_sum: 5
# Q - P: 0
# min Q - P: 0
#____________________________
# For a = [3, 3, 3, 4, 5]:

# a[j]: 3, possible sum: 18
# a[j]: 3, possible sum: 17
# a[j]: 3, possible sum: 16
# a[j]: 3, possible sum: 15
# a[j]: 3, possible sum: 14
# a[j]: 3, possible sum: 13
# a[j]: 3, possible sum: 12
# a[j]: 3, possible sum: 11
# a[j]: 3, possible sum: 10
# a[j]: 3, possible sum: 9
# a[j]: 3, possible sum: 8
# a[j]: 3, possible sum: 7
# a[j]: 3, possible sum: 6
# a[j]: 3, possible sum: 5
# a[j]: 3, possible sum: 4
# a[j]: 3, possible sum: 3
# a[j]: 3, possible sum: 2
# a[j]: 3, possible sum: 1
# a[j]: 3, possible sum: 0
# Mark 3 as possible sum in dp
# row: 0, a[j]: 3, dp: [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# a[j]: 3, possible sum: 18
# a[j]: 3, possible sum: 17
# a[j]: 3, possible sum: 16
# a[j]: 3, possible sum: 15
# a[j]: 3, possible sum: 14
# a[j]: 3, possible sum: 13
# a[j]: 3, possible sum: 12
# a[j]: 3, possible sum: 11
# a[j]: 3, possible sum: 10
# a[j]: 3, possible sum: 9
# a[j]: 3, possible sum: 8
# a[j]: 3, possible sum: 7
# a[j]: 3, possible sum: 6
# a[j]: 3, possible sum: 5
# a[j]: 3, possible sum: 4
# a[j]: 3, possible sum: 3
# Mark 6 as possible sum in dp
# a[j]: 3, possible sum: 2
# a[j]: 3, possible sum: 1
# a[j]: 3, possible sum: 0
# Mark 3 as possible sum in dp
# row: 1, a[j]: 3, dp: [1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# a[j]: 3, possible sum: 18
# a[j]: 3, possible sum: 17
# a[j]: 3, possible sum: 16
# a[j]: 3, possible sum: 15
# a[j]: 3, possible sum: 14
# a[j]: 3, possible sum: 13
# a[j]: 3, possible sum: 12
# a[j]: 3, possible sum: 11
# a[j]: 3, possible sum: 10
# a[j]: 3, possible sum: 9
# a[j]: 3, possible sum: 8
# a[j]: 3, possible sum: 7
# a[j]: 3, possible sum: 6
# Mark 9 as possible sum in dp
# a[j]: 3, possible sum: 5
# a[j]: 3, possible sum: 4
# a[j]: 3, possible sum: 3
# Mark 6 as possible sum in dp
# a[j]: 3, possible sum: 2
# a[j]: 3, possible sum: 1
# a[j]: 3, possible sum: 0
# Mark 3 as possible sum in dp
# row: 2, a[j]: 3, dp: [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# a[j]: 4, possible sum: 18
# a[j]: 4, possible sum: 17
# a[j]: 4, possible sum: 16
# a[j]: 4, possible sum: 15
# a[j]: 4, possible sum: 14
# a[j]: 4, possible sum: 13
# a[j]: 4, possible sum: 12
# a[j]: 4, possible sum: 11
# a[j]: 4, possible sum: 10
# a[j]: 4, possible sum: 9
# Mark 13 as possible sum in dp
# a[j]: 4, possible sum: 8
# a[j]: 4, possible sum: 7
# a[j]: 4, possible sum: 6
# Mark 10 as possible sum in dp
# a[j]: 4, possible sum: 5
# a[j]: 4, possible sum: 4
# a[j]: 4, possible sum: 3
# Mark 7 as possible sum in dp
# a[j]: 4, possible sum: 2
# a[j]: 4, possible sum: 1
# a[j]: 4, possible sum: 0
# Mark 4 as possible sum in dp
# row: 3, a[j]: 4, dp: [1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0]

# a[j]: 5, possible sum: 18
# a[j]: 5, possible sum: 17
# a[j]: 5, possible sum: 16
# a[j]: 5, possible sum: 15
# a[j]: 5, possible sum: 14
# a[j]: 5, possible sum: 13
# Mark 18 as possible sum in dp
# a[j]: 5, possible sum: 12
# a[j]: 5, possible sum: 11
# a[j]: 5, possible sum: 10
# Mark 15 as possible sum in dp
# a[j]: 5, possible sum: 9
# Mark 14 as possible sum in dp
# a[j]: 5, possible sum: 8
# a[j]: 5, possible sum: 7
# Mark 12 as possible sum in dp
# a[j]: 5, possible sum: 6
# Mark 11 as possible sum in dp
# a[j]: 5, possible sum: 5
# a[j]: 5, possible sum: 4
# Mark 9 as possible sum in dp
# a[j]: 5, possible sum: 3
# Mark 8 as possible sum in dp
# a[j]: 5, possible sum: 2
# a[j]: 5, possible sum: 1
# a[j]: 5, possible sum: 0
# Mark 5 as possible sum in dp
# row: 4, a[j]: 5, dp: [1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]

# possible_half_sum: 0
# Q - P: 18
# min Q - P: 18
# possible_half_sum: 1
# possible_half_sum: 2
# possible_half_sum: 3
# Q - P: 12
# min Q - P: 12
# possible_half_sum: 4
# Q - P: 10
# min Q - P: 10
# possible_half_sum: 5
# Q - P: 8
# min Q - P: 8
# possible_half_sum: 6
# Q - P: 6
# min Q - P: 6
# possible_half_sum: 7
# Q - P: 4
# min Q - P: 4
# possible_half_sum: 8
# Q - P: 2
# min Q - P: 2
# possible_half_sum: 9
# Q - P: 0
# min Q - P: 0
