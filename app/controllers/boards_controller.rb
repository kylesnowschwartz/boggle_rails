class BoardsController < ApplicationController
  def index
  end

  def create
    @board = CreateBoard.new.call
    redirect_to @board
  end

  def show
    @board = Board.find(params[:id])
    # @board.board
  end
end
