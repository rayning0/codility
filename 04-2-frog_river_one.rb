require 'set'

def solution(x, a)
    s = Set.new
    a.each_with_index do |leaf, time|
        s << leaf
        return time if s.size == x
    end
    -1
end