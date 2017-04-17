# https://codility.com/demo/results/trainingYEHCRM-PS6/
# Python: https://codility.com/demo/results/trainingA48TY2-D8F/

# Uses "prefix sum" trick from 11-1 Count Semiprimes:
# https://github.com/rayning0/codility/blob/master/11-1-count_semiprimes.rb

# You are given two non-empty zero-indexed arrays A and B consisting of N integers. 
# These arrays represent N planks. A[K] is the start and B[K] the end of the K−th plank.

# Array C consisting of M integers, represents M nails. 
# C[I] is the position where you can hammer in the I−th nail. 
# A plank (A[K], B[K]) is nailed if there exists a nail C[I] such that A[K] ≤ C[I] ≤ B[K].

# Find the min number of nails J that must be used until all the planks nailed. 
# For every plank (A[K], B[K]) such that 0 ≤ K < N, there should exist a
# nail C[I] such that I < J and A[K] ≤ C[I] ≤ B[K].

# 4 planks: [1, 4], [4, 5], [5, 9] and [8, 10]
a = [1, 4, 5, 8]
b = [4, 5, 9, 10]
c = [4, 6, 7, 10, 2]

# if we use the following nails:

# 0, then planks [1, 4] and [4, 5] will both be nailed.
# 0, 1, then planks [1, 4], [4, 5] and [5, 9] will be nailed.
# 0, 1, 2, then planks [1, 4], [4, 5] and [5, 9] will be nailed.
# 0, 1, 2, 3, then all the planks will be nailed.
# Thus, 4 is the min number of nails that, used sequentially, let all planks be nailed.

# Can we nail all planks down w/ given # of nails?
def all_nailed?(a, b, c, nails)
  planks = 0
# N and M are integers within the range [1..30,000];
# each element of arrays A, B, C is an integer within the range [1..2*M];
  nails_marked = [0] * (2 * c.size + 1)

  # mark each nail # with a 1
  nails.times do |i|
    nails_marked[c[i]] = 1
  end

# nails: 4
# nails_marked: [0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1]

  # prefix sums
  (1..nails_marked.size - 1).each do |i|
    nails_marked[i] += nails_marked[i - 1]
  end

# shows how many nails have been hammered in by certain position
# nails_marked: [0, 0, 0, 0, 1, 1, 2, 3, 3, 3, 4]

  a.size.times do |i|
    # prefix sum trick: # of nails hammered in between both ends of plank i
    if nails_marked[b[i]] - nails_marked[a[i] - 1] > 0
      planks += 1
    end
  end
  planks == a.size # if # of planks nailed = all planks, return TRUE
end

def solution(a, b, c)
  min_nails = 1
  max_nails = c.size
  nails = -1
  # binary search: find min # of nails used to get all planks nailed
  while min_nails <= max_nails
    mid_nails = (min_nails + max_nails) / 2
    if all_nailed?(a, b, c, mid_nails)
      max_nails = mid_nails - 1
      nails = mid_nails
    else
      min_nails = mid_nails + 1
    end
  end
  nails
end

# mid_nails: 3
# nails in position: [0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0]
# prefix sum: [0, 0, 0, 0, 1, 1, 2, 3, 3, 3, 3]
# planks nailed: 3, all planks: 4
# mid_nails: 4
# nails in position: [0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1]
# prefix sum: [0, 0, 0, 0, 1, 1, 2, 3, 3, 3, 4]
# planks nailed: 4, all planks: 4
# 4

p solution(a, b, c)