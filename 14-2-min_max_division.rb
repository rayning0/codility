# https://codility.com/demo/results/trainingB3HKU8-XH6/

a = [2, 1, 5, 1, 2, 2, 2]
k = 3
m = 5

# can block_sum fit k blocks?
def block_sum_ok?(k, a, block_sum)
  puts "k: #{k}, block_sum: #{block_sum}"
  bsum = 0
  blocks = 1
  a.each do |elem|
    if bsum + elem > block_sum
      bsum = elem
      blocks += 1
    else
      bsum += elem
    end
    puts "elem: #{elem}, blocks: #{blocks}, bsum: #{bsum}"
    return false if blocks > k
  end
  true
end

# ignore m. it's useless.
# O(N*log(N+M))
def solution(k, m, a)
  min_bsum = a.max
  max_bsum = a.inject(&:+)
  return max_bsum if k == 1
  return min_bsum if k >= a.size

  # binary search on min_sum, given k blocks
  while min_bsum <= max_bsum
    mid_bsum = (min_bsum + max_bsum) / 2
    puts "mid: #{mid_bsum}, min: #{min_bsum}, max: #{max_bsum}"
    if block_sum_ok?(k, a, mid_bsum)
      max_bsum = mid_bsum - 1
      result = mid_bsum
    else
      min_bsum = mid_bsum + 1
    end
  end
  result
end

p solution(k, m, a)

# mid: 10, min: 5, max: 15
# k: 3, block_sum: 10
# elem: 2, blocks: 1, bsum: 2
# elem: 1, blocks: 1, bsum: 3
# elem: 5, blocks: 1, bsum: 8
# elem: 1, blocks: 1, bsum: 9
# elem: 2, blocks: 2, bsum: 2
# elem: 2, blocks: 2, bsum: 4
# elem: 2, blocks: 2, bsum: 6
# mid: 7, min: 5, max: 9
# k: 3, block_sum: 7
# elem: 2, blocks: 1, bsum: 2
# elem: 1, blocks: 1, bsum: 3
# elem: 5, blocks: 2, bsum: 5
# elem: 1, blocks: 2, bsum: 6
# elem: 2, blocks: 3, bsum: 2
# elem: 2, blocks: 3, bsum: 4
# elem: 2, blocks: 3, bsum: 6
# mid: 5, min: 5, max: 6
# k: 3, block_sum: 5
# elem: 2, blocks: 1, bsum: 2
# elem: 1, blocks: 1, bsum: 3
# elem: 5, blocks: 2, bsum: 5
# elem: 1, blocks: 3, bsum: 1
# elem: 2, blocks: 3, bsum: 3
# elem: 2, blocks: 3, bsum: 5
# elem: 2, blocks: 4, bsum: 2
# mid: 6, min: 6, max: 6
# k: 3, block_sum: 6
# elem: 2, blocks: 1, bsum: 2
# elem: 1, blocks: 1, bsum: 3
# elem: 5, blocks: 2, bsum: 5
# elem: 1, blocks: 2, bsum: 6
# elem: 2, blocks: 3, bsum: 2
# elem: 2, blocks: 3, bsum: 4
# elem: 2, blocks: 3, bsum: 6
# 6