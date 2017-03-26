# https://codility.com/demo/results/training2G36QV-PWY/
# O(sqrt(n)) time. O(1) space.
def solution(area)
  min_perimeter = 2 * (1 + area)
  (1..Math.sqrt(area)).each do |width|
    if area % width == 0
      length = area / width
    else
      next
    end
    perimeter = 2 * (length + width)
    min_perimeter = [perimeter, min_perimeter].min
  end
  min_perimeter
end