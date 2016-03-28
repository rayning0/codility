def solution(a)
    n = a.length
    counts = Array.new(n + 1, 0)
    a.each do |num|
        counts[num] = 1 if num.between?(1, n + 1)
    end

    counts.length.times do |count|
      next_count = count + 1
      return next_count if counts[next_count] == 0
    end
    n + 1
end
p solution([5, 10, 1, 15, 2])
