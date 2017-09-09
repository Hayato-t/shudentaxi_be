class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.integer :userid
      t.decimal :here_lat
      t.decimal :here_lng
      t.decimal :obj_lat
      t.decimal :obj_lng

      t.timestamps
    end
  end
end
