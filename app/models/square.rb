class Square < ActiveRecord::Base
  belongs_to :board
  belongs_to :game
  belongs_to :player

  def player?
  end

  def symbol?
  end

end
