# O(n*n*n)
def slow_solution(a)
  sum = 0
  new_array = []
  (0..a.length-3).each do |x|
    (x+1..a.length-2).each do |y|
      (y+1..a.length-1).each do |z|
        new_array = a[x+1..y-1] + a[y+1..z-1]
        sum = [max_slice(new_array), sum].max
      end
    end
  end
  sum
end

def max_slice(array)
  max_ending = max_slice_sum = 0
  array.each do |a|
    max_ending = [0, max_ending + a].max
    max_slice_sum = [max_ending, max_slice_sum].max
  end
  max_slice_sum
end