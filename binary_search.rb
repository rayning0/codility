# Binary search. Array must be SORTED.
# O(log n). Iterative way is 30% faster than recursive!

require 'rspec/autorun'

# recursive
def bsearch_r(a, val)
  i = a.size / 2
  #puts "a: #{a}, i: #{i}"
  return -1 if a.empty?
  return val if a[i] == val
  if a[i] < val
    bsearch_r(a[i + 1..-1], val)
  else
    bsearch_r(a[0..i - 1], val)
  end
end

a = [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99]

p bsearch_r(a, 5)
p bsearch_r(a, 99)
start = Time.now
p bsearch_r(a, 100)
puts "Recursive binary search: #{Time.now - start} secs"

# iterative: 30% faster than recursive!
def bsearch_i(a, val)
  min = 0
  max = a.size - 1
  while min <= max
    mid = (min + max) / 2
    #puts "mid: #{mid}, min: #{min}, max: #{max}"
    return val if a[mid] == val
    if a[mid] < val
      min = mid + 1
    else
      max = mid - 1
    end
  end
  -1
end

p bsearch_i(a, 5)
p bsearch_i(a, 99)
start = Time.now
p bsearch_i(a, 100)
puts "Iterative binary search: #{Time.now - start} secs"

# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [5, 7, 10, 16, 21, 38, 44], i: 3
# a: [5, 7, 10], i: 1
# a: [5], i: 0
# 5
# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [52, 67, 79, 80, 95, 99], i: 3
# a: [95, 99], i: 1
# 99
# a: [5, 7, 10, 16, 21, 38, 44, 46, 52, 67, 79, 80, 95, 99], i: 7
# a: [52, 67, 79, 80, 95, 99], i: 3
# a: [95, 99], i: 1
# a: [], i: 0
# -1

# mid: 6, min: 0, max: 13
# mid: 2, min: 0, max: 5
# mid: 0, min: 0, max: 1
# 5
# mid: 6, min: 0, max: 13
# mid: 10, min: 7, max: 13
# mid: 12, min: 11, max: 13
# mid: 13, min: 13, max: 13
# 99
# mid: 6, min: 0, max: 13
# mid: 10, min: 7, max: 13
# mid: 12, min: 11, max: 13
# mid: 13, min: 13, max: 13
# -1
#__________________________________
# Q: Given n binary values x0, x1, . . . , xn−1, such that xi is either 0 or 1. This array
# represents holes in a roof (1 is a hole). You are also given k boards of same size.
# Choose the optimal (minimal) size of the boards that allows all holes to be covered by boards.

# Board size comes from binary search. If size s covers all holes, then size > s
# also covers all holes. All size < s won't cover holes.

# Returns # of boards, for given size, you need to cover all holes.
# Use GREEDY algorithm to add new board only if there's hole not covered by last board
def num_of_boards(a, size)
  boards = 0
  end_of_board = -1
  a.size.times do |i|
    if a[i] == 1 && end_of_board < i
      boards += 1
      end_of_board = i + size - 1
    end
  end
  boards
end

# O(n log n)
def board_size(a, k)
  min_size = 1
  max_size = a.size
  # binary search: O(log n)
  while min_size <= max_size
    mid_size = (min_size + max_size) / 2
    boards = num_of_boards(a, mid_size) # O(n)
    return mid_size if boards == k
    #puts "mid_size: #{mid_size}, boards: #{boards}"
    if boards < k
      max_size = mid_size - 1 # shrinking board size increases # of boards
    else
      min_size = mid_size + 1 # raising board size decreases # of boards
    end
  end
  -1
end

describe 'Board Size' do
  it "gives board size to cover all holes (1's) in array, given k boards" do
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 1)).to eq 7
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 2)).to eq 4
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 3)).to eq 3
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 4)).to eq 2
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 5)).to eq 1
    expect(board_size([0, 1, 0, 1, 1, 1, 0, 1], 6)).to eq -1
  end
end