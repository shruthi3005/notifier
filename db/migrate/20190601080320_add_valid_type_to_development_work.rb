class AddValidTypeToDevelopmentWork < ActiveRecord::Migration[5.1]
  def change
    add_column :development_works, :valid_type_id, :integer, index: true
  end
end
