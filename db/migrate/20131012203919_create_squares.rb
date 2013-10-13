class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.belongs_to	:board
      t.belongs_to	:game
      t.belongs_to	:player
      t.integer	  	:x
      t.integer     :y

      t.timestamps
    end

    add_index :squares, :game_id
    add_index :squares, :board_id
    add_index :squares, :player_id
  end
end
