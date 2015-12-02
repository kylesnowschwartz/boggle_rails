require 'pp'

class CheckWordAgainstBoard
  attr_reader :word, :board
  
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

  def initialize(word, board)
    @word = word
    @board = board.chars
  end

  def call
    breadth_first_search(ADJACENCY_LIST, board, word)
  end

  private

  def breadth_first_search(graph, board, word)
    board.map.with_index do |letter, index|
      if letter == first_letter(word)
        bfs_info = setup_bfs_info(graph, board, word, index)
        queue = []
        queue << index

        while queue.any?
          current_vertex = queue.shift

          graph[current_vertex].each do |neighbor|
            if not_seen_before?(bfs_info, neighbor) && matching_letters?(word, bfs_info, board, current_vertex, neighbor)
              
              increment_distance(bfs_info, neighbor, current_vertex)

              bfs_info[neighbor][:letter] = board[neighbor]
              
              bfs_info[neighbor][:predecessor] = current_vertex

              queue << neighbor

              return trace_backwards_to_word(bfs_info, word, board) if bfs_info[neighbor][:distance] == (word.size - 1)
            end
          end
        end
      end
    end
    false
  end

  def first_letter(word)
    word.chars.first
  end

  def increment_distance(bfs_info, neighbor, current_vertex)
    bfs_info[neighbor][:distance] = bfs_info[current_vertex][:distance] + 1
  end

  def not_seen_before?(bfs_info, neighbor)
    bfs_info[neighbor][:distance] == nil
  end

  def matching_letters?(word, bfs_info, board, current_vertex, neighbor)
    word.chars[bfs_info[current_vertex][:distance] + 1] == board[neighbor]
  end

  def trace_backwards_to_word(info, word, board)
    letters = []

    word.size.times do |i|
      last_letter = info.select { |datapoint| datapoint[:distance] == word.size - i - 1}
      last_letter_index = last_letter[0][:index]
      letters.unshift(board[last_letter_index])
    end

    letters.join
  end

  def setup_bfs_info(graph, board, word, source_vertex)
    bfs_info = []
    graph.length.times { |i| bfs_info[i] = {index: i, distance: nil, predecessor: nil, letter: nil} }
    bfs_info[source_vertex][:distance] = 0
    bfs_info[source_vertex][:letter] = word.chars.first
    bfs_info
  end
end

# Example
# LUCK
# SKIL
# LIMB
# RIMS

# word = "LIMBS"
# board = "LUCKSKILLIMBRIMS"
# p CheckWordAgainstBoard.new(word, board).call == word

# word = "RISK"
# board = "LUCKSKILLIMBRIMS"
# p CheckWordAgainstBoard.new(word, board).call == word