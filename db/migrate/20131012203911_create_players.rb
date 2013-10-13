class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to	:game
      t.references	:board
      t.string		:name
      t.string		:symbol

      t.timestamps
    end

    add_index :players, :game_id
    add_index :players, :board_id
  end
end
