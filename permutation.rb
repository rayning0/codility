# Permutation algorithms: https://www.cs.princeton.edu/~rs/talks/perms.pdf

# recursive, no swaps
# for array
def permute(a)
  return [a] if a.size < 2
  perms = []
  a.each do |elem|
    permute(a - [elem]).each do |p|
      perms << ([elem] + p)
    end
  end
  perms
end

# p permute([2, 5, 8, 9])

# [[2, 5, 8, 9], [2, 5, 9, 8], [2, 8, 5, 9], [2, 8, 9, 5], [2, 9, 5, 8], [2, 9, 8, 5],
#  [5, 2, 8, 9], [5, 2, 9, 8], [5, 8, 2, 9], [5, 8, 9, 2], [5, 9, 2, 8], [5, 9, 8, 2],
#  [8, 2, 5, 9], [8, 2, 9, 5], [8, 5, 2, 9], [8, 5, 9, 2], [8, 9, 2, 5], [8, 9, 5, 2],
#  [9, 2, 5, 8], [9, 2, 8, 5], [9, 5, 2, 8], [9, 5, 8, 2], [9, 8, 2, 5], [9, 8, 5, 2]]

# for string
# p permute('code'.split('')).map(&:join)

# ["code", "coed", "cdoe", "cdeo", "ceod", "cedo",
#  "ocde", "oced", "odce", "odec", "oecd", "oedc",
#  "dcoe", "dceo", "doce", "doec", "deco", "deoc",
#  "ecod", "ecdo", "eocd", "eodc", "edco", "edoc"]

# recursive, backtracking
# for array. Has DUPLICATES.
# 3 params: a = array, l = start index, r = end index
# http://www.geeksforgeeks.org/write-a-c-program-to-print-all-permutations-of-a-given-string/
def permute(a, l, r)
  if l == r
    p a
  else
    a.size.times do |i|
      a[l], a[i] = a[i], a[l]
      permute(a, l + 1, r)
      a[l], a[i] = a[i], a[l] # backtracking
    end
  end
end

# Has duplicates:
# [2, 1, 3]
# [1, 2, 3]
# [1, 3, 2]
# [1, 2, 3]
# [2, 1, 3]
# [2, 3, 1]
# [2, 3, 1]
# [3, 2, 1]
# [3, 1, 2]

# recursive, backtracking
# for string
# store results in Set
require 'set'
def permute(a, l, r, ans = Set.new)
  puts "a: #{a}, l: #{l}, r: #{r}, ans: #{ans.to_a}"
  if l == r
    b = a.dup.join # without "dup," original array gets changed and ans has only 1 permutation
    ans.add(b)
  else
    a.size.times do |i|
      a[l], a[i] = a[i], a[l]
      permute(a, l + 1, r, ans)
      a[l], a[i] = a[i], a[l] # backtracking
    end
  end
  ans.to_a.sort
end

a = 'cod'.split('')
# a = [1, 2, 3]
l = 0
r = a.size - 1
p permute(a, l, r)

# a: ["c", "o", "d"], l: 0, r: 2, ans: []
# a: ["c", "o", "d"], l: 1, r: 2, ans: []
# a: ["o", "c", "d"], l: 2, r: 2, ans: []
# a: ["c", "o", "d"], l: 2, r: 2, ans: ["ocd"]
# a: ["c", "d", "o"], l: 2, r: 2, ans: ["ocd", "cod"]
# a: ["o", "c", "d"], l: 1, r: 2, ans: ["ocd", "cod", "cdo"]
# a: ["c", "o", "d"], l: 2, r: 2, ans: ["ocd", "cod", "cdo"]
# a: ["o", "c", "d"], l: 2, r: 2, ans: ["ocd", "cod", "cdo"]
# a: ["o", "d", "c"], l: 2, r: 2, ans: ["ocd", "cod", "cdo"]
# a: ["d", "o", "c"], l: 1, r: 2, ans: ["ocd", "cod", "cdo", "odc"]
# a: ["o", "d", "c"], l: 2, r: 2, ans: ["ocd", "cod", "cdo", "odc"]
# a: ["d", "o", "c"], l: 2, r: 2, ans: ["ocd", "cod", "cdo", "odc"]
# a: ["d", "c", "o"], l: 2, r: 2, ans: ["ocd", "cod", "cdo", "odc", "doc"]

# ["cdo", "cod", "dco", "doc", "ocd", "odc"]

# Best method: Heap's algorithm
# https://en.wikipedia.org/wiki/Heap%27s_algorithm
