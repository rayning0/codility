# like 7-1, but don't need stack

def solution(s)
  parens = 0
  s.split('').each do |char|
    if char == '('
      parens += 1
    else
      parens -= 1
      return 0 if parens < 0  # fails without this line
    end
  end
  if parens == 0
    1
  else
    0
  end
end