class BoardsController < ApplicationController
  def index
  end

  def create
    @board = CreateBoard.new.call
    redirect_to @board
  end

  def show
    @board = Board.find(params[:id])
    @validated_words = ValidateWords.new(@board.words, @board).call
    @validated_words[:valid_words].map! { |word| (word + " " + ScoreWord.new(word).call.to_s) }
  end
end
