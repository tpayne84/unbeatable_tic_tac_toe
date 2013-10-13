class SquaresController < ApplicationController
  before_action :set_square, only: [:update, :destroy]

  def new
    @square = @board.squares.build
  end

  def create
    @square = @board.squares.new(square_params)
    @square.save
  end

  def update
    @square.update(square_params)
    redirect_to @square.game
  end

  def destroy
    @square.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_square
      @square = Square.find(params[:id])
    end

    def square_params
      params.permit(:player, :player_id, :game, :board, :id)
    end
end
