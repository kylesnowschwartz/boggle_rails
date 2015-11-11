class Board < ActiveRecord::Base
  has_many :words, dependent: :destroy

  attr_reader :letters, :board

  DICE = [
    "AAEEGN", "ELRTTY", "AOOTTW", "ABBJOO", 
    "EHRTVW", "CIMOTU", "DISTTY", "EIOSST", 
    "DELRVY", "ACHOPS", "HIMNQU", "EEINSU", 
    "EEGHNW", "AFFKPS", "HLNNRZ", "DEILRX"
  ]

  def new_board!
    shake!

    @board = []

    a = qs_to_qus(@letters)
    
    4.times { @board << a.shift(4) }
    
    @board
  end

  def shake!
    roll_each_die
  end

  def roll_each_die
    @letters = ""

    randomly_ordered_die_array.each do |die|
      @letters += roll_a_die(die)
    end
  end

  def randomly_ordered_die_array
    DICE.shuffle
  end

  def roll_a_die(die)
    die.split("").sample
  end

  def qs_to_qus(string)
    string.chars.map{|letter| letter == "Q" ? "Qu" : letter}
  end
end


