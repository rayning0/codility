# https://codility.com/demo/results/trainingAWFUGJ-A6U/
# a = [1, 5, 3, 4, 3, 4, 1, 2, 3, 4, 6, 2]

def find_peaks(a)
  peaks = [false]
  (1..a.size - 2).each do |i|
    if a[i] > a[i - 1] && a[i] > a[i + 1]
      peaks << true
    else
      peaks << false
    end
  end
  peaks
end

def next_peak(a)
  peaks = find_peaks(a)
  nexxt = [0] * a.size
  nexxt[a.size - 1] = -1
  (a.size - 2).downto(0).each do |i|
    if peaks[i]
      nexxt[i] = i
    else
      nexxt[i] = nexxt[i + 1]
    end
  end
  nexxt
end

# check if we can set f flags
# def check(f, a)
#   # 1. find all peaks
#   peaks = find_peaks(a)
#   pos = 0
#   flags = f
#   while pos < a.size && flags > 0
#     if peaks[pos]
#       flags -= 1
#       pos += f
#     else
#       pos += 1
#     end
#   end
#   flags == 0
# end

# O(n)
def solution(a)
  nexxt = next_peak(a)
  f = 1 # can we set f flags?
  max_flags = 0
  # (f-1) * f = max distance between first and last flags
  while (f - 1) * f <= a.size
    pos = 0
    flags_so_far = 0
    while pos < a.size && flags_so_far < f
      pos = nexxt[pos]
      break if pos == -1
      flags_so_far += 1
      pos += f
    end
    max_flags = [max_flags, flags_so_far].max
    f += 1
  end
  max_flags
end

describe 'Flags' do
  it '#solution' do
    expect(solution([5])).to eq 0
    expect(solution([1, 5, 3, 4, 3, 4, 1, 2, 3, 4, 6, 2])).to eq 3
    expect(solution([1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1])).to eq 4
    expect(solution([1, 2, 1, 2, 1])).to eq 2
    expect(solution([1, 2, 1, 2, 1, 2, 1])).to eq 2
    expect(solution([1, 2, 1, 1, 2, 1, 1, 2, 1])).to eq 3
    expect(solution([1, 2, 1, 1, 2, 1, 2, 1])).to eq 2
    expect(solution([1, 1, 1, 1])).to eq 0
    expect(solution([1, 2, 2, 2, 2, 3, 2, 2, 2, 2, 1])).to eq 1
    expect(solution([1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1])).to eq 2
    expect(solution([1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1])).to eq 3
    expect(solution([1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 2, 1])).to eq 4
    expect(solution([1, 2, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1])).to eq 3
  end
end