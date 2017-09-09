class Destroymatcing < ActiveRecord::Migration[5.1]
  def change
    drop_table :matchings
  end
end
