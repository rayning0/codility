# https://codility.com/demo/results/trainingYU359Z-X8P/

def solution(a)
  # codesays.com/2014/solution-to-min-avg-two-slice-by-codility
  # Says 2 and 3 element slices MUST contain the min average for whole array.
  # No need to check bigger slices.
  min_avg = 10000
  min_start_pos = 0
  (0..a.length - 3).each do |i|
      # All 2-element slices:
      two_avg = (a[i] + a[i + 1]) / 2.0
      # All 3-element slices:
      three_avg = (a[i] + a[i + 1] + a[i + 2]) / 3.0
      avg = [two_avg, three_avg].min
      if avg < min_avg
        min_avg = avg
        min_start_pos = i
      end
  end
  avg = (a[-1] + a[-2]) / 2.0
  min_start_pos = a.length - 2 if avg < min_avg
  min_start_pos
end