def grocery_store(a)
  zeroes, ones = 0, 0
  a.each do |action|
    if action == 0
      zeroes += 1
    else
      ones += 1
    end
  end
  if zeroes - ones < 0
    (zeroes - ones).abs
  else
    0
  end
end

a = [1, 1, 0, 0, 1, 0, 0]
p grocery_store(a)