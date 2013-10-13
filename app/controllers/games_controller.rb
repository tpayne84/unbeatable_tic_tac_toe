class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :set_cells, only: [:show]

  def index
    @games = Game.all
  end

  def show
    
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)
    @board = @game.build_board(:game => @game)
    @computer = @game.players.build(:name => "computer", :symbol => "O")
    @human = @game.players.build(:name => params[:game][:player][:name], :symbol => "X")
    @game.computers_move = false
    @game.save

    # now make the squares
    (0..2).each do |row|
      (0..2).each do |col|
        Square.create(:x => col, :y => row, :game => @game, :board => @board)
      end
    end

    redirect_to @game
  end

  def update
    @game.update(game_params)
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

    def set_cells
      rows = ['a','b','c']
      cols = (1..3)
      @squares = Square.where('board_id == ?', @game.board.id)
      @cell_ids = []
      rows.each do |row|
        cols.each do |col|
          cell = row + col.to_s
          @cell_ids << cell
        end
      end
      @board_squares = Hash.new
      (0..8).each { |i| @board_squares[@cell_ids[i]] = @squares[i] }
      @board_squares
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_board
      @board = @game.board
    end

    def game_params
      params.require(:game).permit(:id, :board, :player, :squares, :computers_move)
    end
end
