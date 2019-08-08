class AddFyToDevelopmentWork < ActiveRecord::Migration[5.1]
  def up
    add_column :development_works, :fy, :year
    change_column :development_works, :sanctioned_amount, :float, limit: 20
    change_column :development_works, :estimated_amount, :float, limit: 20
  end
  def down
    remove_column :development_works, :fy
    change_column :development_works, :sanctioned_amount, :float
    change_column :development_works, :estimated_amount, :float
  end
end
