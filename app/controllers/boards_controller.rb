class BoardsController < ApplicationController
  def index
  end

  def create
    @board = Board.create!

    redirect_to @board
  end

  def show
    @board = Board.find(params[:id])
  end
end
