# https://codility.com/demo/results/training2BXZUD-TDS/

def solution(array)
  max_ending = max_slice = array.first
  array.shift # delete 1st element
  array.each do |element| # start loop from 2nd element
    max_ending = [element, max_ending + element].max
    max_slice = [max_ending, max_slice].max
  end
  max_slice
end

# If array = [5] (1 element), array.shift empties array,
# so it skips loop.

# If array = [-10, -2, -5] (all negative),
# max_slice = -2 (max negative value)

# If array = [-2, 1, 2] (1st number < 0)
# max_ending = -2
# In loop, max_ending = [1, -2 + 1].max = 1, so we skip 1st number
