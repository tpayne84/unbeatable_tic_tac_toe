class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :empty_squares, only: [:show, :edit, :update, :destroy]
  before_action :set_cells, only: [:show]

  def index
    @games = Game.all
  end

  def show
    @board.wins.each_with_index do |set, i|
      concat = ''
      @winner = 'none'
      set.each {|sqr| concat += @board_squares[sqr].player.symbol unless @board_squares[sqr].player == nil}
      if concat == 'XXX'
        # human wins
        @winner = "human"
        break
      elsif concat == 'OOO'
        # computer wins
        @winner = "computer"
        break
      elsif @board.blanks.size == 0
        @winner = "draw"
        break
      elsif concat == 'OO'
        # go for win
        if @board.blanks.size.even? && @board.move(set, @game.players[0])
          redirect_to @game
        end
      elsif concat == 'XX'
        # go for block
        if @board.blanks.size.even? && @board.move(set, @game.players[0])
          redirect_to @game
        end
      elsif @board.blanks.size == 8
        # check where human moved
        if @board_squares['b2'].player_id == nil
          # take the center
          if @board.blanks.size.even? && @board.move(['b2'], @game.players[0])
            redirect_to @game
          end
        else
          square_set = ['a1','a3','c1','c3']
          # take a corner
          if @board.blanks.size.even? && @board.move(square_set, @game.players[0])
            redirect_to @game
          end
        end
      elsif @board.blanks.size == 2 
        # any slot will do
        sqr = square_to_name(@board.blanks.first)
        if @board.blanks.size.even? && @board.move([sqr], @game.players[0])
          redirect_to @game
        end
      else
        # any slot will do
        sqr = square_to_name(@board.blanks.first)
        if @board.blanks.size.even? && @board.move([sqr], @game.players[0])
          @board.blanks.first.save
          redirect_to @game
        end
      end
    end
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

    def square_to_name(square)
      case square.y
      when 0
        'a' + (square.x + 1).to_s
      when 1
        'b' + (square.x + 1).to_s
      when 2
        'c' + (square.x + 1).to_s
      end
     end

    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_board
      @board = @game.board
    end

    def empty_squares
      @empty_squares = Square.where(game_id: params[:id], player_id: nil)
    end

    def game_params
      params.require(:game).permit(:id, :board, :player, :squares, :computers_move)
    end
end
