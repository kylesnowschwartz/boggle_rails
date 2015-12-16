class SubmissionsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    
    SubmitWords.new(params[:submission][:words], @board).call

    redirect_to @board
  end
end
