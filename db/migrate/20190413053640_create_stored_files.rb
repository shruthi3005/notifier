class CreateStoredFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :stored_files do |t|
      t.string :storage_type
      t.integer :storage_id
      t.string :desc
      t.string :document

      t.timestamps
    end
  end
end
