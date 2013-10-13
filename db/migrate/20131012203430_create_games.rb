class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean		:computers_move

      t.timestamps
    end
	
  end
end
