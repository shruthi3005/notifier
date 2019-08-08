class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.references :entity_status, foreign_key: true
      t.references :department, foreign_key: true
      t.references :place, foreign_key: true
      t.text :details, limit: 4294967295
      t.string :feedback_type
      t.text :action_taken
      t.string :name

      t.timestamps
    end
  end
end
