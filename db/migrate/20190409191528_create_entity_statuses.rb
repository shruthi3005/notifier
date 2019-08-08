class CreateEntityStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :entity_statuses do |t|
      t.string :entity_type
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
