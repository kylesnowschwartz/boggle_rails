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
      random_die_face(die)
    end.join
  end

  def randomly_ordered_dice
    DICE.shuffle
  end

  def random_die_face(die)
    die.chars.sample
  end
end