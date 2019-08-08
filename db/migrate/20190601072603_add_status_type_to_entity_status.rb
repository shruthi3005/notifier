class AddStatusTypeToEntityStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :entity_statuses, :typed, :boolean, default: false
  end
end
