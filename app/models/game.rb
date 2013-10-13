class Game < ActiveRecord::Base
  has_one :board
  has_many :players
  has_many :squares, :through => :board
  accepts_nested_attributes_for :players

end
