class WordsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    
    ParseWords.new(params[:word][:words], @board).call

    redirect_to @board
  end
end
