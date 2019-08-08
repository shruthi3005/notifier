class CreateBeneficiarySchemes < ActiveRecord::Migration[5.1]
  def change
    create_table :beneficiary_schemes do |t|
      t.references :place, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.references :scheme_type, foreign_key: true, index: true
      t.string :beneficiary_phone
      t.string :beneficiary_name
      t.date :application_date
      t.text :granted_relief
      t.string :status
      t.text :remarks

      t.timestamps
    end
  end
end
