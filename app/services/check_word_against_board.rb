require 'pp'

class CheckWordAgainstBoard
end
  
  POSITIONS_TO_COORDINATES = {
    0 => [0,0],  
    1 => [0,1],  
    2 => [0,2],  
    3 => [0,3],
    4 => [1,0],  
    5 => [1,1],  
    6 => [1,2],  
    7 => [1,3],
    8 => [2,0],  
    9 => [2,1], 
    10 => [2,2], 
    11 => [2,3],
    12 => [3,0], 
    13 => [3,1], 
    14 => [3,2], 
    15 => [3,3]
  }
  
ADJACENCY_LIST = [
  [1, 4, 5],
  [2, 6, 5, 4, 0],
  [3, 7, 6, 5, 1],
  [7, 6, 2],
  [0, 1, 5, 9, 8],
  [0, 1, 2, 6, 10, 9, 8, 4],
  [1, 2, 3, 7, 11, 10, 9, 5],
  [3, 2, 6, 10, 11],
  [4, 5, 9, 13, 12],
  [4, 5, 6, 10, 14, 13, 12, 8],
  [5, 6, 7, 11, 15, 14, 13, 9],
  [7, 6, 10, 14, 15],
  [8, 9, 13],
  [8, 9, 10, 14, 12],
  [13, 9, 10, 11, 15],
  [11, 10, 14]
]

def breadth_first_search(graph, board, word)
  board.map.with_index do |letter, index|
    if letter == word.chars.first
      bfs_info = setup_bfs_info(graph, board, word, index)
      queue = []
      queue << index

      while queue.any?
        current_vertex = queue.shift

        graph[current_vertex].each do |neighbor|
          if bfs_info[neighbor][:distance] == nil && word.chars[bfs_info[current_vertex][:distance] + 1] == board[neighbor] 
            bfs_info[neighbor][:distance] = bfs_info[current_vertex][:distance] + 1
            bfs_info[neighbor][:letter] = board[neighbor]
            
            bfs_info[neighbor][:predecessor] = current_vertex

            queue << neighbor

            return bfs_info if bfs_info[neighbor][:distance] == (word.size - 1)
          end
        end
      end
    bfs_info
    end
  end
end

# TODO try mapping backwards
def map_backwords(info, word)
  word.size.times do |i|
    info.select { |datapoint| datapoint[:distance] == word.size - i }
  end
end

def setup_bfs_info(graph, board, word, source_vertex)
  bfs_info = []
  graph.length.times { |i| bfs_info[i] = {index: i, distance: nil, predecessor: nil, letter: nil} }
  bfs_info[source_vertex][:distance] = 0
  bfs_info[source_vertex][:letter] = word.chars.first
  bfs_info
end

def recursive_check(board, letters_to_check, indices_seen)
  if letters_to_check.empty?
    p "found a path"
  end
  return true if letters_to_check == []

  board.each_with_index do |cell, index|
    if cell == letters_to_check.first && not_seen && adjacent
      remaining_letters = letters_to_check.dup
      remaining_letters.shift
      # p '-' * 20
      # p remaining_letters
      recursive_check(board, remaining_letters)
    end
  end

  false
end

word = "LIMBS"
board = "LUCKSKILLIMBRIMS".chars

# pp recursive_check(board, word)
# LUCK
# SKIL
# LIMB
# RIMS

bfs = breadth_first_search(ADJACENCY_LIST, board, word)
pp bfs

# bfs = [{:distance=>2, :preceeding_letter=>"S"},
#  {:distance=>2, :preceeding_letter=>"S"},
#  {:distance=>2, :preceeding_letter=>"K"},
#  {:distance=>3, :preceeding_letter=>"C"},
#  {:distance=>1, :preceeding_letter=>"L"},
#  {:distance=>1, :preceeding_letter=>"L"},
#  {:distance=>2, :preceeding_letter=>"K"},
#  {:distance=>3, :preceeding_letter=>"C"},
#  {:distance=>0, :preceeding_letter=>nil},
#  {:distance=>1, :preceeding_letter=>"L"},
#  {:distance=>2, :preceeding_letter=>"K"},
#  {:distance=>3, :preceeding_letter=>"I"},
#  {:distance=>1, :preceeding_letter=>"L"},
#  {:distance=>1, :preceeding_letter=>"L"},
#  {:distance=>2, :preceeding_letter=>"I"},
#  {:distance=>3, :preceeding_letter=>"M"}]
