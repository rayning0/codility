# codility.com/demo/results/trainingAXJ5N7-8T6/
# Python (thanks Alex Wice!): codility.com/demo/results/training4J6PQV-A4N/

# O(N * (N + M))
# 100% correct, 40% performance
def slow_solution(m, a)
  n = a.size
  return 1 if n == 1
  distinct = 0
  n.times do |back|
    (back..n - 1).each do |front|
      if a[back..front] == a[back..front].uniq
        distinct += 1
      else
        break
      end
    end
  end
  distinct
end

a = [3, 4, 5, 5, 2]
m = 6

# For each value of "front", "back" is the farthest left we can
# be where values array[back..front] are all UNIQUE.
# This adds front - back + 1 to # of distinct slices,
# since (back, back), (back, back+1),...(back, front) are all unique slices'
# Our main loop counts the number of unique arrays ending in "front"

a = [3, 4, 5, 5, 2]
m = 6
MAX_SLICES = 1e9.to_i

# O(N): both cursors (back, front) only move FORWARD. Never backward.
def fast_solution(m, a)
  multiples = 0 # number of #'s in freq that occur >= 2 times

  back = distinct = 0
  freq = Hash.new(0)
  a.each_with_index do |elem, front|
    puts "back: #{back}, front: #{front}, elem: #{elem}, a[#{back}..#{front}]: #{a[back..front]}"

    freq[elem] += 1
    multiples += 1 if freq[elem] > 1

    puts "freq: #{freq}, multiples: #{multiples}"
    while multiples > 0
      # Move back index forward 1 step. 
      # Have we gotten rid of the element that gave us multiple > 1?
      # Does our (back, front) slice still have multiples?
      freq[a[back]] -= 1
      multiples -= 1 if freq[a[back]] == 1
      back += 1

      puts "freq: #{freq}, multiples: #{multiples}, back: #{back}, front: #{front}, a[#{back}..#{front}]: #{a[back..front]}"
    end
    distinct += front - back + 1
    puts "distinct: #{distinct}"
  end
  [distinct, MAX_SLICES].min
end

p fast_solution(m, a)

# back: 0, front: 0, elem: 3, a[0..0]: [3]
# freq: {3=>1}, multiples: 0
# distinct: 1. Slices: (0, 0)

# back: 0, front: 1, elem: 4, a[0..1]: [3, 4]
# freq: {3=>1, 4=>1}, multiples: 0
# distinct: 3. Slices: (0, 0), (0, 1), (1, 1)

# back: 0, front: 2, elem: 5, a[0..2]: [3, 4, 5]
# freq: {3=>1, 4=>1, 5=>1}, multiples: 0
# distinct: 6. Slices: (0, 0), (0, 1), (1, 1), (0, 2), (1, 2), (2, 2)

# back: 0, front: 3, elem: 5, a[0..3]: [3, 4, 5, 5]
# freq: {3=>1, 4=>1, 5=>2}, multiples: 1
# freq: {3=>0, 4=>1, 5=>2}, multiples: 1, back: 1, front: 3, a[1..3]: [4, 5, 5]
# freq: {3=>0, 4=>0, 5=>2}, multiples: 1, back: 2, front: 3, a[2..3]: [5, 5]
# freq: {3=>0, 4=>0, 5=>1}, multiples: 0, back: 3, front: 3, a[3..3]: [5]
# distinct: 7. Slices: (0, 0), (0, 1), (1, 1), (0, 2), (1, 2), (2, 2), (3, 3)

# back: 3, front: 4, elem: 2, a[3..4]: [5, 2]
# freq: {3=>0, 4=>0, 5=>1, 2=>1}, multiples: 0
# distinct: 9. Slices: (0, 0), (0, 1), (1, 1), (0, 2), (1, 2), (2, 2), (3, 3), (3, 4), (4, 4)
# 9
