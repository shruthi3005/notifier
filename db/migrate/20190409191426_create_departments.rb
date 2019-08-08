class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :code
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
