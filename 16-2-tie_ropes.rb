# Greedy Algorithm
#https://codility.com/demo/results/demo93VRFP-B3X/

# O(n)
def solution(k, a)
    total = 0
    ropes = 0
    a.each do |rope_length|
        total += rope_length
        if total >= k
            ropes += 1
            total = 0
        end
    end
    ropes
end
