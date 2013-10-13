class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.belongs_to	:game

      t.timestamps
    end

    add_index :boards, :game_id
  end
end
