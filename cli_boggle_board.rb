class BoggleBoard
  def initialize
    # @alphabet_array = ("A".."Z").to_a
    @die_array = [
      "AAEEGN", "ELRTTY", "AOOTTW", "ABBJOO", 
      "EHRTVW", "CIMOTU", "DISTTY", "EIOSST", 
      "DELRVY", "ACHOPS", "HIMNQU", "EEINSU", 
      "EEGHNW", "AFFKPS", "HLNNRZ", "DEILRX"
    ]
    @board = [
      ["____"],
      ["____"],
      ["____"],
      ["____"]
    ]
  end

  def shake!
    puts "---New Board---"
    # 4.times {@board << random_letter.shift(4)}
    clear_board_and_place_dice_in_board
    roll_all_16_dice
    q_to_qu
  end

  # def random_letter
  #   @alphabet_array.shuffle
  # end

  def q_to_qu
    @board.map! { |row| row.map{|letter| letter == "Q" ? "Qu" : letter} }
  end

  def clear_board_and_place_dice_in_board
    @board.clear
    4.times { @board << @die_array.shuffle.shift(4) }
  end

  def roll_all_16_dice
    @board.each do |row|
      row.map! do |die|
        split_up = die.split("")
        split_up.sample
      end
    end
  end

  def to_s
    @board.map{ |row| row.join("") }.join("\n")
  end

end

# class Die
#   def initialize(sides = 6)
#     @sides = sides
#     @die_hash = {
#       "die_1" => "AAEEGN",
#       "die_2" => "ELRTTY",
#       "die_3" => "AOOTTW",
#       "die_4" => "ABBJOO",
#       "die_5" => "EHRTVW",
#       "die_6" => "CIMOTU",
#       "die_7" => "DISTTY",
#       "die_8" => "EIOSST",
#       "die_9" => "DELRVY",
#       "die_10" => "ACHOPS",
#       "die_11" => "HIMNQU",
#       "die_12" => "EEINSU",
#       "die_13" => "EEGHNW",
#       "die_14" => "AFFKPS",
#       "die_15" => "HLNNRZ",
#       "die_16" => "DEILRX"
#     }
#   end

#   def roll
#   @die_hash.each do |die_number, die_sides|
#     die_sides.split("").shuffle.first
#     @board << die_number.shuffle
#   end
# end

board = BoggleBoard.new
puts "---Blank Board---"
puts board
# An unshaken board prints out something sensible, like:
# ____
# ____
# ____
# ____

# Shake (and modify) the board
board.shake!

puts board
# Prints out:
# DUMV
# KSPD
# HCDA
# ZOHG

board.shake!
puts board

# We've shaken again, so a new random board:
# QIRZ
# EEBY
# OEJE
# MHCU