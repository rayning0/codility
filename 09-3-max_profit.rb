# a = [25, 23, 30, 20, 16]
# max_profit = 7
# profit = -20
# price = 16
# min = 16
# max = 0

# loop: price - all previous prices, then compare to max_profit
# If we set a new min, we reset max to 0

def solution(a)
  return 0 if a.empty?
  min = a.shift
  max = a.first
  profit = max - min
  max_profit = profit
  a.each do |price|
    if price < min
      min = price
      max = 0
    elsif price > max
      max = price
    end
    profit = max - min
    max_profit = [max_profit, profit].max
  end
  max_profit > 0 ? max_profit : 0
end