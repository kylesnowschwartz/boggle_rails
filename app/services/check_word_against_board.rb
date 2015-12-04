class CheckWordAgainstBoard
  attr_reader :word, :board_chars, :adjacency_list, :indicies_to_check

  def initialize(word, board)
    @word = word
    @board_chars = board.chars
    @adjacency_list = CalculateAdjacencyList.new(board_chars.length).call
    @indicies_to_check = []
  end

  def call
    breadth_first_search(adjacency_list)
  end

  private

  def breadth_first_search(adjacency_list)
    board_chars.each_with_index do |letter, index|
      indicies_to_check.clear
      indicies_to_check << index

      if found_first_letter?(letter)
        bfs_info = setup_bfs_info(index)

        while indicies_to_check.any?
          current_vertex = indicies_to_check.shift

          return word if process_neighbors_at_current_vertex(current_vertex, bfs_info) == word
        end
      end
    end
    
    nil
  end

  def process_neighbors_at_current_vertex(current_vertex, bfs_info)
    adjacency_list[current_vertex].each do |neighbor|
      if not_seen_before?(bfs_info, neighbor) && matching_letters?(bfs_info, current_vertex, neighbor)
        
        increment_distance(bfs_info, neighbor, current_vertex)

        bfs_info[neighbor][:letter] = board_chars[neighbor]
        
        bfs_info[neighbor][:predecessor] = current_vertex

        indicies_to_check << neighbor

        return trace_backwards_to_word(bfs_info) if bfs_info[neighbor][:distance] == (word.size - 1)
      end
    end
  end

  def found_first_letter?(letter)
    letter == first_letter
  end

  def increment_distance(bfs_info, neighbor, current_vertex)
    bfs_info[neighbor][:distance] = bfs_info[current_vertex][:distance] + 1
  end

  def not_seen_before?(bfs_info, neighbor)
    bfs_info[neighbor][:distance] == nil
  end

  def matching_letters?(bfs_info, current_vertex, neighbor)
    word.chars[bfs_info[current_vertex][:distance] + 1] == board_chars[neighbor]
  end

  def trace_backwards_to_word(info)
    letters = []

    word.size.times do |i|
      last_letter = info.select { |datapoint| datapoint[:distance] == word.size - i - 1}
      last_letter_index = last_letter[0][:index]
      letters.unshift(board_chars[last_letter_index])
    end

    letters.join
  end

  def setup_bfs_info(source_vertex)
    bfs_info = []
    board_chars.length.times { |i| bfs_info[i] = {index: i, distance: nil, predecessor: nil, letter: nil} }
    bfs_info[source_vertex][:distance] = 0
    bfs_info[source_vertex][:letter] = first_letter
    bfs_info
  end

  def first_letter
    word.chars.first
  end
end

# Example
# LUCK
# SKIL
# LIMB
# RIMS

# word = "LIMBS"
# board_chars = "LUCKSKILLIMBRIMS"
# p CheckWordAgainstboard.new(word, board_chars).call == word

# word = "RISK"
# board_chars = "LUCKSKILLIMBRIMS"
# p CheckWordAgainstboard.new(word, board_chars).call == word