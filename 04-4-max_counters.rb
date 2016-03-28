# https://codility.com/demo/results/trainingYQCNE6-6HN/

def solution(n, a)
    counter = Array.new(n, 0)
    max_to_set = 0
    max_now = 0
    a.each do |num|
        if num == n + 1
            max_to_set = max_now
        else # 1 <= num <= n
            counter[num - 1] = max_to_set if counter[num - 1] < max_to_set
            counter[num - 1] += 1
            max_now = counter[num - 1] if counter[num - 1] > max_now
        end
        # p counter
    end
    counter.size.times do |i|
        counter[i] = max_to_set if counter[i] < max_to_set
    end
    counter
end