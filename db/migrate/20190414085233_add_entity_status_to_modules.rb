class AddEntityStatusToModules < ActiveRecord::Migration[5.1]
  def change
    add_reference :development_works, :entity_status, foreign_key: true, index: true
    add_reference :beneficiary_schemes, :entity_status, foreign_key: true, index: true
  end
end
