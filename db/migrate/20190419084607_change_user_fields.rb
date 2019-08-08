class ChangeUserFields < ActiveRecord::Migration[5.1]
  def change
    # fields
    add_column :users, :access_token, :string, index: true
    add_column :users, :access_token_expiry, :datetime
    add_column :users, :user_type, :string
    add_column :users, :dob, :date

    # indexes
    remove_index :users, :email
    add_index :users, :phone, unique: true
  end
end
