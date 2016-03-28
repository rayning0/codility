# https://codility.com/demo/results/trainingY6JNCP-TWA/

def solution(a)
    west = 0    # cars going west
    passing = 0 # pairs of passing cars
    a.reverse_each do |direction|
        if direction == 0   # east
            # add cars that have passed west so far
            passing += west
        else
            west += 1
        end
    end
    return -1 if passing > 1000000000
    passing
end