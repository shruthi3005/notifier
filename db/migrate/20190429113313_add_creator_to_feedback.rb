class AddCreatorToFeedback < ActiveRecord::Migration[5.1]
  def change
    add_reference :feedbacks, :user, foreign_key: true, index: true
  end
end
