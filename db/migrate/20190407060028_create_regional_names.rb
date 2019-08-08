class CreateRegionalNames < ActiveRecord::Migration[5.1]
  def change
    create_table :regional_names do |t|
      t.string :name
      t.string :holder_type
      t.integer :holder_id, index: true

      t.timestamps
    end
  end
end
