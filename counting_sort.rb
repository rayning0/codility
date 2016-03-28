# https://codility.com/media/train/4-Sorting.pdf

a = [12, 15, 8, 4, 12, 4, 3, 12, 2, 8, 15, 12, 3, 10, 6, 2, 12, 0, 3]
# all elements are in set 0..k

def counting_sort(a, k)
  count = Array.new(k + 1, 0)
  result = []
  a.each do |num|
    count[num] += 1
  end

  count.each_with_index do |freq, num|
    puts "num: #{num}, freq: #{freq}"
    freq.times do
      result << num
    end
  end
  result
end

p counting_sort(a, 15)