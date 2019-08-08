class AddInternalToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :taluks, :internal, :boolean, default: false
    add_column :panchayats, :internal, :boolean, default: false
    add_column :places, :internal, :boolean, default: false
  end
end
