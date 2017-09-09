class CreateTaxiallotments < ActiveRecord::Migration[5.1]
  def change
    create_table :taxiallotments do |t|
      t.decimal :pos_lat
      t.decimal :pos_lng

      t.timestamps
    end
  end
end
