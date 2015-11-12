class WordsController < ApplicationController
  def create
    p params[:word]
    @board = Board.find(params[:board_id])

    @word = Word.create!(board: @board, word: params[:word])

    redirect_to @board
  end
end
