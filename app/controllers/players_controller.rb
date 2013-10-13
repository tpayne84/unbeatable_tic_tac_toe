class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:new, :create]
  
  
  def new
    @player = @game.players.build
  end

  def create
    @player = @game.players.new(player_params)
    @player.save
      end

  def destroy
    @player.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:player, :game, :board, :name, :symbol)
    end
end
