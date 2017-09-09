class CreateFeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :feelings do |t|
      t.integer :userid
      t.integer :like
      t.integer :fight
      t.string :comment_content
      t.string :comment_imgpath
      t.decimal :comment_lat
      t.decimal :comment_lng

      t.timestamps
    end
  end
end
