class CreatePanchayats < ActiveRecord::Migration[5.1]
  def change
    create_table :panchayats do |t|
      t.references :taluk, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
