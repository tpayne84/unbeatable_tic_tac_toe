class Player < ActiveRecord::Base
  belongs_to :game
  has_one :board, :through => :board
  has_many :squares, :through => :board

  def has_in_a_row?(num) 	
  end

  def best_set?  	
  end

end
