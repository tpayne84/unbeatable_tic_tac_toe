class Game < ActiveRecord::Base
  has_one :board
  has_many :players
  has_many :squares, :through => :board
  accepts_nested_attributes_for :players

  def toggle_turn
  	if self.computers_move == false
  		self.computers_move = true
  	else
  		self.computers_move = false
  	end
  	self.save
  end

end
