class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :push
      t.boolean :mail
      t.boolean :phone
      t.date :expiry

      t.timestamps
    end
  end
end
