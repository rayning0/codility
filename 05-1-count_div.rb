# count number of integers divisible by k in range [a..b].

def solution(a, b, k)
    if (a % k == 0)
        return (b - a) / k + 1
    else
        return (b - (a - a % k)) / k
    end
end