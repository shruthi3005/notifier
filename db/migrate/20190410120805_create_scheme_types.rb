class CreateSchemeTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :scheme_types do |t|
      t.string :name
      t.string :sub_type

      t.timestamps
    end
  end
end
