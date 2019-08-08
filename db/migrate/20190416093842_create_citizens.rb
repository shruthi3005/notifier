class CreateCitizens < ActiveRecord::Migration[5.1]
  def change
    create_table :citizens do |t|
      t.text :addl_details
      t.string :pincode
      t.string :gender
      t.text :address
      t.string :email
      t.string :phone
      t.string :name
      t.string :age
      t.date :dob 

      t.references :place, foreign_key: true, index: true
      t.references :position, foreign_key: true, index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
