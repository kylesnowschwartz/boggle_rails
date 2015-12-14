class CreateBoard
  DICE = [
    "AAEEGN", "ELRTTY", "AOOTTW", "ABBJOO", 
    "EHRTVW", "CIMOTU", "DISTTY", "EIOSST", 
    "DELRVY", "ACHOPS", "HIMNQU", "EEINSU", 
    "EEGHNW", "AFFKPS", "HLNNRZ", "DEILRX"
  ]

  def call
    Board.create!(letters: shaken_letters)
  end

  private

  def shaken_letters
    randomly_ordered_dice.map do |die|
      roll_a_die(die)
    end.join
  end

  def randomly_ordered_dice
    DICE.shuffle
  end

  def roll_a_die(die)
    die.chars.sample
  end
end