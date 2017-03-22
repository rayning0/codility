# https://codility.com/demo/results/training5EEH22-NT7/
# a = [25, 23, 30, 20, 16]
# max_profit = 7
# profit = -20
# price = 16
# min = 16
# max = 0

# If see a new min, reset max to 0

# O(n)
def solution(a)
  return 0 if a.empty?
  min = a.shift
  max = a.first
  profit = max - min
  max_profit = profit
  a.each do |price|
    if price > max
      max = price
    elsif price < min
      min = price
      max = 0 # this price and all later prices won't be used for max_profit, until we see a price > max
    end
    profit = max - min
    max_profit = [max_profit, profit].max
  end
  max_profit > 0 ? max_profit : 0
end