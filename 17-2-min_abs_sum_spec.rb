# Not working yet
# a = [1, 5, 2, -2]
# s = [-1, 1, -1, 1]

# summation
def val(a, s)
  sum = 0
  a.size.times do |i|
    sum += a[i] * s[i]
  end
  sum.abs
end

# if either 1 or -1 is valid, pick -1

# [1]               -1
# [1, 5]            -1    1

# [1, 5, 2]         -1    1
# [1, 5, 2, -2]


def solution(a)
  # dp = [0] + [MAXINT] * (a.size)
  dp = []
  (0..a.size - 1).each do |col|
    num = a[col]
    arr = a[0..col]
    pos_s = dp + [1]
    neg_s = dp + [-1]
    if val(arr, pos_s) < val(arr, neg_s)
      dp << 1
    else
      dp << -1
    end
    puts "col: #{col}, dp: #{dp[col]}"
  end
  p "dp #{dp}. val: #{val(a, dp)}"
  puts
  val(a, dp)
end

describe '#solution' do
  it 'tests something' do
    expect(solution([])).to eq 0
    expect(solution([1, 5, 2, -2])).to eq 0
    expect(solution([-100, -100, -50, -20, -25])).to eq 5
    expect(solution([100, 100, 50, 20, 25])).to eq 5
    expect(solution([0, 0, 0])).to eq 0
    expect(solution([3, 3, 3, 4, 5])).to eq 0
  end
end
