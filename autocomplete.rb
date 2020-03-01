# Coding Exercise: Autocomplete
# Given a list of words and a list of user keyboard actions (keystrokes or WAIT), produce an array of suggested words (sorted lexicographically) for every time a WAIT action is encountered.

# Possible actions are:
# - keystroke (a-zA-Z0-9)
# - WAIT
# - BACKSPACE

# Example:
# Input:
# ****************************
# wordList = ["cats", "cat", "cap", "cape", "cute", "cuts"]
# actions = ["c", "a", "WAIT", "BACKSPACE", "u", "t", "WAIT"]

# Expected Output:
# ****************************
# [["cap", "cape", "cat", "cats"], ["cute", "cuts"]]

# Better answer: use a trie
# https://www.youtube.com/watch?v=zIjfhVPRZCg
class TrieNode
  @val = "c"
  @children = {c: TrieNode}
  @end_of_word = true
end

# c
# |
# a  --
# |   |    |
# p   t    d

# DFS with stack LIFO
# BFS with queue FIFO

# ['cap', 'cat']

# O(n * m)
def solution(word_list, actions)
  string = ''
  result = []
  word_list.sort!

  actions.each do |action|
    case action
    when 'WAIT'
      result << word_list.select { |word| word =~ /^#{string}/ }
    when 'BACKSPACE'
      string = string[0..-2]
    else
      string += action
    end
  end

  result
end

describe '#solution' do
  it 'returns suggested words based on what user types' do
    word_list = ["cats", "cat", "cap", "cape", "cute", "cuts"] # m
    actions = ["c", "a", "WAIT", "BACKSPACE", "u", "t", "WAIT"] # n
    expect(solution(word_list, actions)).to eq [["cap", "cape", "cat", "cats"],
      ["cute", "cuts"],]
  end
end




