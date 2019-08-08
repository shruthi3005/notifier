class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :vid_url
      t.string :desc
      t.integer :media_id
      t.string :media_type

      t.timestamps
    end
  end
end
