class WordsController < ApplicationController
  def create
    p params[:word]
    @board = Board.find(params[:board_id])

    ParseWords.new(params[:word][:word], @board).call

    redirect_to @board
  end
end
