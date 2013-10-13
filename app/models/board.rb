class Board < ActiveRecord::Base
  belongs_to :game
  has_many :squares, :through => :game
  has_many :players, :through => :game

	def wins
		wins = []
		cols = ['a','b','c']
		rows = [1,2,3]

		# verticle wins
		rows.each do |row|
			vert_row = []
			cols.each do |col|
				sqr = col + row.to_s
				vert_row << sqr
			end
			wins << vert_row
		end

		# verticle wins
		cols.each do |col|
			vert_row = []
			rows.each do |row|
				sqr = col + row.to_s
				vert_row << sqr
			end
			wins << vert_row
		end

		# diagonal rows
		diag_row = ['a1','b2','c3']
		wins << diag_row
		diag_row = ['c1','b2','a3']
		wins << diag_row
	end
  
	def one_away(square_name)
		case square_name
		    when 'a1'
		      one_away = ['b1','b2','a2']
		    when 'a2'
		      one_away = ['a1','b2','a3']
		    when 'a3'
		      one_away = ['a2','b2','b3']
		    when 'b1'
		      one_away = ['c1','b2','a1']
		    when 'b2'
		      one_away = ['a1','a2','a3','b1','b3']
		    when 'b3'
		      one_away = ['a3','b2','c3']
		    when 'c1'
		      one_away = ['c2','b2','b1']
		    when 'c2'
		      one_away = ['c1','b2','c3']
		    when 'c3'
		      one_away = ['c2','b2','b3']
		end
		one_away
	end

	def move(square_set, player)
		set_cells

		square_set.each_with_index do |sqr,i|
			if @board_squares[sqr].player_id == nil
				@board_squares[sqr].player_id = player.id
				@board_squares[sqr].save
				return true
			end
		end
		return false
	end

    def set_cells
      rows = ['a','b','c']
      cols = (1..3)
      @squares = Square.where('board_id == ?', self.id)
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

	def blanks
		Square.where(player_id: nil, board_id: self.id)
	end
end