class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key:true, index: true
      t.references :entity_status, foreign_key: true
      t.string :org_name
      t.string :event_name
      t.string :venue
      t.text :details
      t.date :req_date
      t.time :req_time
      t.date :opt_date
      t.time :opt_time
      t.text :remarks

      t.timestamps
    end
  end
end
