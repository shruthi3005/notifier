class IndexPhoneNumbersInCitizen < ActiveRecord::Migration[5.1]
  def change
    add_index :citizens, :phone
  end
end
