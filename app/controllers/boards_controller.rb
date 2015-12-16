class BoardsController < ApplicationController
  def index
  end

  def create
    redirect_to CreateBoard.new.call
  end

  def show
    @board = Board.find(params[:id])

    @validated_words = ValidateWords.new(@board.submissions, @board).call

    @board_grid = BoardPresenter.new(@board).call
  end
end
