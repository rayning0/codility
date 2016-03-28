# Greedy Algorithm
#https://codility.com/demo/results/demo93VRFP-B3X/

def solution(k, a)
    # write your code in Ruby 1.9.3
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

#Time complexity: O(N)