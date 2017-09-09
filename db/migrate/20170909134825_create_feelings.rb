class CreateFeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :feelings do |t|
      t.integer :userid
      t.decimal :comment_lat
      t.decimal :comment_lng
      t.string :comment_body
      t.string :comment_imgpath
      t.integer :like
      t.integer :fight

      t.timestamps
    end
  end
end
