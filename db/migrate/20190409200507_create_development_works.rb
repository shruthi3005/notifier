class CreateDevelopmentWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :development_works do |t|
      t.references :department, foreign_key: true, index: true
      t.references :place, foreign_key: true, index: true
      t.text :desc, limit: 4294967295
      t.float :estimated_amount
      t.float :sanctioned_amount
      t.date :foundation_date
      t.date :inaugration_date
      t.string :status
      t.string :name
      t.text :remarks, limit: 4294967295

      t.timestamps
    end
  end
end
