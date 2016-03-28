def solution(a)
    n = a.length
    return 1 if n == 0
    # 1 + 2 + 3 + ... + n + 1
    sum_should_be = (n + 1) * (n + 2) / 2
    sum = a.reduce(&:+)
    sum_should_be - sum
end