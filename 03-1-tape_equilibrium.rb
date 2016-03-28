
def solution(a)
    n_minus1 = a.length - 1
    first = a[0]
    second = a[1..n_minus1].reduce(&:+)
    min_diff = (first - second).abs
    (1..n_minus1 - 1).each do |i|
        first += a[i]
        second -= a[i]
        diff = (first - second).abs
        min_diff = diff if diff < min_diff
    end
    min_diff
end

p solution([3, 1, 2, 4, 3])