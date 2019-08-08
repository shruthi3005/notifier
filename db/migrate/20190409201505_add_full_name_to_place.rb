class AddFullNameToPlace < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :full_name, :string
  end
end
