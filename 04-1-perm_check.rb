require 'set'

def solution(a)
# A permutation is a sequence containing each
# element from 1 to N once, and only once.
    n = a.length
    s = Set.new
    a.each do |num|
        return 0 if num > n
        s << num
    end
    return 1 if s.size == n
    0
end