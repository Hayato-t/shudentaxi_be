class CreateMatchedgroups < ActiveRecord::Migration[5.1]
  def change
    create_table :matchedgroups do |t|
      t.integer :userid1
      t.integer :userid2
      t.integer :userid3
      t.string :taxi_number
      t.decimal :taxi_lat
      t.decimal :taxi_lng
      t.decimal :obj_lat
      t.decimal :obj_lng
      t.integer :report
      t.integer :members
      t.integer :closed_flag
      t.integer :delete_flag
      t.timestamps
    end
  end
end
