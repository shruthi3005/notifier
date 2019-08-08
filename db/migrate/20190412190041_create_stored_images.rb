class CreateStoredImages < ActiveRecord::Migration[5.1]
  def change
    create_table :stored_images do |t|
      t.string :media_type
      t.integer :media_id
      t.string :image
      t.string :desc

      t.timestamps
    end
  end
end
