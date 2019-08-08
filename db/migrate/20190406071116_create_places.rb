class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :panchayat, foreign_key: true
      t.string :name
      t.string :code
      t.string :place_type

      t.timestamps
    end
  end
end
