class CalculateAdjacencyList
  attr_reader :size, :boundary

  def initialize(size)
    @size = size
    @boundary = Math.sqrt(size).to_i
  end

  def call
    calculate_adjacency_list
  end

  private

  def calculate_adjacency_list
    size.times.map do |cell_id|
      possible_neighbours(cell_id_to_coord(cell_id))
        .map { |coordinate| coord_to_cell_id(coordinate) }.sort
    end
  end

  def possible_neighbours((row, col))
    [
      [row    , col - 1], 
      [row    , col + 1], 
      [row - 1, col    ], 
      [row + 1, col    ], 
      [row - 1, col - 1], 
      [row + 1, col + 1],
      [row - 1, col + 1], 
      [row + 1, col - 1] 
    ].select { |coordinate| is_valid?(coordinate) }
  end

  def cell_id_to_coord(cell_id)
    [cell_id_to_row(cell_id), cell_id_to_col(cell_id)]
  end

  def coord_to_cell_id((row, col))
    row * boundary + col
  end

  def is_valid?((row, col))
    row.between?(0, (boundary - 1)) && col.between?(0, (boundary - 1))
  end

  def cell_id_to_row(cell_id)
    cell_id / boundary
  end

  def cell_id_to_col(cell_id)
    cell_id % boundary
  end
end
