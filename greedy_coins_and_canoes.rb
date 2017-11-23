# Find min # of coins with which a given amount of $ can be paid. Use greedy algorithm (not optimal). Make locally best choice at any given moment, which may not be overall best choice.

def greedy_coin_changing(coins, amount)
  result = []
  (coins.size - 1).downto(0).each do |i|
    result << [coins[i], amount / coins[i]]
    amount %= coins[i]  # amount left after using coins[i]
  end
  result
end

coins = [2, 3, 5, 6]
amount = 10
p greedy_coin_changing(coins, amount)

# Output: [coin value, # of coins]
# [[6, 1], [5, 0], [3, 1], [2, 0]]. Non-optimal answer.
# To return total of <= 10, we use one 6 coin and one 3 coin.


# There are n canoeists weighing w0, w1,...wn-1. w is sorted array.
# Seat them in min # of 2-seat canoes w/ max load of max_load. Each guy weighs <= max_load.
def greedy_canoe_a(w, max_load)
  skinny, fat = [], []

  # Divide w into 2 arrays: skinny, fat
  w.size.times do |i|
    if w[i] + w[-1] <= max_load
      skinny << w[i]
    else
      fat << w[i]
    end
  end

  # fat << w[-1]  <---mistake in Codility 14-GreedyAlgorithms PDF?
  canoes = 0

  while skinny.any? || fat.any?
    puts "Skinny: #{skinny}, Fat: #{fat}"
    # put heaviest skinny guy w/ heaviest fat guy
    s = skinny.any? ? skinny.pop : ''
    f = fat.pop
    puts "Put #{s}, #{f} in 1 canoe"
    canoes += 1

    # after enmptying "fat", move heaviest skinny guy back to "fat"
    if skinny.any? && fat.empty?
      fat << skinny.pop
    end

    # if lightest + heaviest fat guys can fit in canoe,
    # move lightest fat guy to "skinny," so next loop pairs them
    while fat.size > 1 && fat[0] + fat[-1] <= max_load
      skinny << fat.shift
    end
  end
  puts "Total canoes: #{canoes}"
  canoes
end

w = [5, 8, 10, 17, 20, 21, 25, 30]
max_load = 50
greedy_canoe_a(w, max_load)

# Skinny: [5, 8, 10, 17, 20], Fat: [21, 25, 30]
# Put 20, 30 in 1 canoe
# Skinny: [5, 8, 10, 17, 21], Fat: [25]
# Put 21, 25 in 1 canoe
# Skinny: [5, 8, 10], Fat: [17]
# Put 10, 17 in 1 canoe
# Skinny: [5], Fat: [8]
# Put 5, 8 in 1 canoe
# Total canoes: 4
#
w = [5, 8, 10, 17, 20, 21, 25, 30]
max_load = 30
greedy_canoe_a(w, max_load)
#
# Skinny: [], Fat: [5, 8, 10, 17, 20, 21, 25, 30]
# Put , 30 in 1 canoe
# Skinny: [5], Fat: [8, 10, 17, 20, 21, 25]
# Put 5, 25 in 1 canoe
# Skinny: [8], Fat: [10, 17, 20, 21]
# Put 8, 21 in 1 canoe
# Skinny: [10], Fat: [17, 20]
# Put 10, 20 in 1 canoe
# Skinny: [], Fat: [17]
# Put , 17 in 1 canoe
# Total canoes: 5

# O(n): Sit fattest canoeist with the thinnest, as long as total weight <= max_load. If not, fattest canoeist is seated alone in canoe.
def greedy_canoe_b(w, max_load)
  canoes = 0
  i, j = 0, w.size - 1

  while i <= j
    if w[i] + w[j] <= max_load
      puts "Sit #{w[i]}, #{w[j]} in 1 canoe. Total weight #{w[i] + w[j]}"
      i += 1
    else
      puts "Sit #{w[j]} alone in 1 canoe."
    end
    canoes += 1
    j -= 1
  end
  puts "Total canoes: #{canoes}"
  canoes
end

w = [5, 8, 10, 17, 20, 21, 25, 30]
max_load = 30

# greedy_canoe_b(w, max_load)

# Sit 30 alone in 1 canoe.
# Sit 5, 25 in 1 canoe. Total weight 30
# Sit 8, 21 in 1 canoe. Total weight 29
# Sit 10, 20 in 1 canoe. Total weight 30
# Sit 17 alone in 1 canoe.
# Total canoes: 5
