class CreateBoard
  DICE = [
    "AAEEGN", "ELRTTY", "AOOTTW", "ABBJOO", 
    "EHRTVW", "CIMOTU", "DISTTY", "EIOSST", 
    "DELRVY", "ACHOPS", "HIMNQU", "EEINSU", 
    "EEGHNW", "AFFKPS", "HLNNRZ", "DEILRX"
  ]

  def call
    shake!
    Board.create!(letters: @letters)
  end

  def shake!
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
end