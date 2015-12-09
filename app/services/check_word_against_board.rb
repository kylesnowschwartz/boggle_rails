class CheckWordAgainstBoard
  attr_reader :word, :board_chars, :adjacency_list, :indicies_to_check, :bfs_info
  def initialize(word, board)
    @board_chars ||= board.chars
    @adjacency_list ||= CalculateAdjacencyList.new(board_chars.length).call
    @word = word
    @indicies_to_check = []
    @bfs_info = []
  end

  def call
    breadth_first_search(adjacency_list)
  end

  private

  def breadth_first_search(adjacency_list)
    board_chars.each_with_index do |letter, index|
      indicies_to_check.clear

      if found_first_letter?(letter)
        bfs_info.clear
        bfs_info = setup_bfs_info(index)
        indicies_to_check << [index, bfs_info]

        while indicies_to_check.any?
          current_vertex_and_bfs = indicies_to_check.shift
          current_bfs = current_vertex_and_bfs[1]
          current_vertex = current_vertex_and_bfs[0]

          return word if process_neighbors_at_current_vertex(current_vertex, current_bfs) == word
        end
      end
    end
    
    nil
  end

  def process_neighbors_at_current_vertex(current_vertex, current_bfs)
    adjacency_list[current_vertex].each do |neighbor|
      @current_path = copy_bfs(current_bfs)

      if not_seen_before?(neighbor) && neighbor_matches_next_letter?(neighbor, current_vertex)
        increment_distance(neighbor, current_vertex)

        record_letter(neighbor)
        
        @current_path[neighbor][:preceding] = current_vertex

        @current_path[neighbor][:index] = neighbor
        
        indicies_to_check << [neighbor, @current_path]

        if reached_word_end?(neighbor)
          return trace_backwards_to_word(@current_path)
        end
      end
    end
  end

  def found_first_letter?(letter)
    letter == first_letter
  end

  def reached_word_end?(cell_id)
    @current_path[cell_id][:distance] == (word.size - 1)
  end

  def increment_distance(cell_id, current_vertex)
    if @current_path[cell_id][:distance].nil?
      @current_path[cell_id][:distance] = @current_path[current_vertex][:distance] + 1
    else
      @current_path[cell_id][:distance] += 1
    end
  end

  def record_letter(cell_id)
    @current_path[cell_id][:letter] = board_chars[cell_id]
  end

  def not_seen_before?(cell_id)
    @current_path[cell_id][:letter] == nil
  end

  def neighbor_matches_next_letter?(cell_id, current_vertex)
    current_letter_in_word = word.chars[@current_path[current_vertex][:distance]] 
    
    neighbor_being_checked = board_chars[cell_id]

    next_letter_in_word = word.chars[@current_path[current_vertex][:distance] + 1] 
    
    next_next_letter = word.chars[@current_path[current_vertex][:distance] + 2] 

    if current_letter_in_word == "Q" && next_letter_in_word == "U" && neighbor_being_checked != "U"
      increment_distance(cell_id, current_vertex)

      next_next_letter == neighbor_being_checked
    else
      next_letter_in_word == neighbor_being_checked
    end
  end

  def trace_backwards_to_word(path)
    entry = path.select { |cell_info| cell_info[:distance] == word.size - 1 }.first
    trace = [entry]
    
    while entry[:preceding].present?
      previous_entry = path[entry[:preceding]]
      trace << previous_entry
      entry = previous_entry
    end

    letters = []
    trace.reverse.each do |entry|
      letters[entry[:distance]] = entry[:letter]
    end

    letters.map { |letter| letter.nil? ? "U" : letter }.join
  end

  def setup_bfs_info(source_vertex)
    board_chars.length.times { |i| bfs_info[i] = {distance: nil, letter: nil, preceding: nil, index: nil} }
    bfs_info[source_vertex][:distance] = 0
    bfs_info[source_vertex][:letter] = first_letter
    bfs_info[source_vertex][:index] = source_vertex
    bfs_info
  end

  def copy_bfs(bfs)
    bfs.map(&:dup)
  end

  def first_letter
    word.chars.first
  end
end