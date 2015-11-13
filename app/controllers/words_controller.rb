class WordsController < ApplicationController
  def create
    params[:word]
    @board = Board.find(params[:board_id])
    ParseWords.new(params[:word][:words], @board).call

    redirect_to @board
  end
end
