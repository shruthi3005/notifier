class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :details, limit: 4294967295
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :venue
      t.text :remarks

      t.timestamps
    end
  end
end
