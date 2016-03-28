# http://blog.codility.com/2011/03/solutions-for-task-equi.html
# O(n) space/time complexity answer

def solution(a)
    return -1 if a.length == 0
    total_sum = a.inject(&:+)
    left_sum = 0
    a.each_with_index do |element, i|
        right_sum = total_sum - element - left_sum
        return i if left_sum == right_sum
        left_sum += element
    end
    -1
end

a = [-1, 3, -4, 5, 1, -6, 2, 1]
puts solution(a)