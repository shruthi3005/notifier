class CreateTaluks < ActiveRecord::Migration[5.1]
  def change
    create_table :taluks do |t|
      t.references :district, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
