class Board < ActiveRecord::Base
  belongs_to :game
  has_many :squares, :through => :game
  has_many :players, :through => :game

  def winning_sets
  end

  def open_slots  	
  end

  def is_move_valid?(square)
  end

end