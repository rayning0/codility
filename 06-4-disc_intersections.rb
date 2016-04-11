def solution(a)
  upper, lower = [], []
  low_index = 0
  intersections = 0
  a.each_with_index do |radius, center|
    upper << center + radius
    lower << center - radius
  end

  upper.sort!
  lower.sort!

  upper.each_with_index do |up, up_index|
    while (low_index < a.size && up >= lower[low_index])
      # low_index only goes up, not down. Avoids double counting
      low_index += 1
    end
    intersections += (low_index - up_index - 1)
  end
  if intersections > 10_000_000
    -1
  else
    intersections
  end
end

# This got 100% correct, but 60% performance = O(n*n)
# def solution(a)
#   intersections = 0
#   ranges = []
#   a.each_with_index do |radius, center|
#     ranges << [center - radius, center + radius]
#   end
#   puts "ranges: #{ranges} \n\n"

#   (0..a.length - 2).each do |center|
#     left_edge1 = center - a[center]
#     right_edge1 = center + a[center]

#     (center + 1..a.length - 1).each do |center2|
#       puts "center: #{center}, center2: #{center2}"
#       if center2 != center
#         left_edge2 = center2 - a[center2]
#         right_edge2 = center2 + a[center2]

#         if left_edge2 <= right_edge1
#           intersections += 1
#           puts "Disc #{center} intersects Disc #{center2}. Center #{center} between #{left_edge2} and #{right_edge2}\n\n"
#         end
#       end
#     end
#   end
#   intersections
# end


a = [1, 5, 2, 1, 4, 0]

p solution(a)

# ranges: [[-1, 1], [-4, 6], [0, 4], [2, 4], [0, 8], [5, 5]]

# center: 0, center2: 1
# Disc 0 intersects Disc 1. Center 0 between -4 and 6

# center: 0, center2: 2
# Disc 0 intersects Disc 2. Center 0 between 0 and 4

# center: 0, center2: 3
# center: 0, center2: 4
# Disc 0 intersects Disc 4. Center 0 between 0 and 8

# center: 0, center2: 5
# center: 1, center2: 2
# Disc 1 intersects Disc 2. Center 1 between 0 and 4

# center: 1, center2: 3
# Disc 1 intersects Disc 3. Center 1 between 2 and 4

# center: 1, center2: 4
# Disc 1 intersects Disc 4. Center 1 between 0 and 8

# center: 1, center2: 5
# Disc 1 intersects Disc 5. Center 1 between 5 and 5

# center: 2, center2: 3
# Disc 2 intersects Disc 3. Center 2 between 2 and 4

# center: 2, center2: 4
# Disc 2 intersects Disc 4. Center 2 between 0 and 8

# center: 2, center2: 5
# center: 3, center2: 4
# Disc 3 intersects Disc 4. Center 3 between 0 and 8

# center: 3, center2: 5
# center: 4, center2: 5
# Disc 4 intersects Disc 5. Center 4 between 5 and 5

# 11