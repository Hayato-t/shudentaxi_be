class CreateMatchedgroups < ActiveRecord::Migration[5.1]
  def change
    create_table :matchedgroups do |t|
      t.integer :userid1
      t.integer :userid2
      t.integer :userid3
      t.string :taxi_number
      t.decimal :taxi_lat
      t.decimal :taxi_lng

      t.timestamps
    end
  end
end
