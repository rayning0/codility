def solution(x, y, d)
    jumps = (y - x) / d
    if (y - x) % d == 0
        return jumps
    else
        return jumps + 1
    end
end