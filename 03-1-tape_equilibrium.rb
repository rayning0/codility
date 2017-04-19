
def solution(a)
    first = a[0]
    second = a[1..-1].reduce(&:+)
    min_diff = (first - second).abs
    (1..a.size - 1).each do |p|
        first += a[p]
        second -= a[p]
        diff = (first - second).abs
        min_diff = diff if diff < min_diff
    end
    min_diff
end

p solution([3, 1, 2, 4, 3])