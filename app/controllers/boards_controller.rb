class BoardsController < ApplicationController
  def index
  end

  def create
    @board = CreateBoard.new.call
    p "in create: #{@board.board}"
    redirect_to @board
  end

  def show
    @board = Board.find(params[:id])
    p "in show: #{@board.board}"
    p @board.board
  end
end
