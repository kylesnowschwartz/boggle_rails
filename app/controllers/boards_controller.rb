class BoardsController < ApplicationController
  def index
  end

  def create
    redirect_to CreateBoard.new.call
  end

  def show
    @board = Board.find(params[:id])
    @validated_words = ValidateWords.new(@board.words, @board).call
  end
end
