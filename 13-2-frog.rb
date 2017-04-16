# https://codility.com/demo/results/training6524VV-MAF/
# what's size of smallest subset of array of Fibonacci nums
# that sums to n + 1 (other side of bank)
# and are actual leaves in river (in a)?

require 'rspec/autorun'

# http://codility-lessons.blogspot.com/2015/03/lesson-11-fibfrog-fib-frog.html
def solution(a)
  n = a.size

  # for n = 0-2, the distance to jump from `-1' (the origin)
  # can be 1-3---all Fibonacci nums
  return 1 if n <= 2

  # Min jumps to reach this position:
  # Cells 0 and 1 can be reached when leaves are there.
  # Since they can be reached in first jump, we just care if they have leaves or not
  reachable = [a[0], a[1]] + [0] * (n - 1)

  # Since n <= 100,000 and fib(25) == 75025, fib(26) = 121393,
  # we only have to generate 25 Fibonacci numbers.
  fib = [0, 1]

  (2..25).each do |i|
    fib[i] = fib[i - 1] + fib[i - 2]
    return 1 if fib[i] == n + 1  # if 1 jump reaches other side, we're done

    # mark positions reachable by 1st jump from shore
    aindex = fib[i] - 1
    if fib[i] < n + 1 && a[aindex] == 1
      reachable[aindex] = 1
    end
  end

  min_jumps = n + 2  # set it too high to start

  n.times do |i|
    next if reachable[i] == 0 #ignore if leaf not reachable
    min_jumps_to_i = reachable[i]

    # Make new jump from reachable leaf, looping through all Fib nums
    (2..fib.size - 1).each do |j|
      next_pos = i + fib[j]
      jumps_to_next_pos = min_jumps_to_i + 1

      if next_pos == n  # crossed river!
        if jumps_to_next_pos < min_jumps
          min_jumps = jumps_to_next_pos
          break
        end
      end

      # next jump too big, or no leaf there
      next if next_pos > n || a[next_pos] == 0

      # if we've never reached next position before,
      # or we can reach next pos with fewer jumps,
      # update min number of jumps at that pos.
      if reachable[next_pos] == 0 || jumps_to_next_pos < reachable[next_pos]
        reachable[next_pos] = jumps_to_next_pos
      end
    end
  end
  # reachable: [0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0] for initial example

  # if min_jumps never changed, return -1
  min_jumps == n + 2 ? -1 : min_jumps
end

describe 'Frog' do
  it '#solution' do
    expect(solution([0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0])).to eq 3
    expect(solution([])).to eq 1
    expect(solution([1, 1, 1])).to eq 2
    expect(solution([1, 1])).to eq 1
  end
end