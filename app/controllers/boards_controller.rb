class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def new
    @board = @game.board.build
  end

  def create
    @board = @game.board.new(board_params)
    @board.save
  end

  def destroy
    @board.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:player, :game, :squares)
    end

end
