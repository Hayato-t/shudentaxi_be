class Destroyfeeling < ActiveRecord::Migration[5.1]
  def change
    drop_table :feelings
  end
end
