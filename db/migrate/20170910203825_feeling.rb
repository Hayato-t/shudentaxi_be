class Feeling < ActiveRecord::Migration[5.1]
  def change
    create_table :feelings do |t|
      t.integer :userid
      t.decimal :comment_lat
      t.decimal :comment_lng
      t.string :comment_body
      t.string :comment_imgpath
      t.integer :like, default: 0
      t.integer :fight, default: 0
      t.timestamps
    end
  end
end
