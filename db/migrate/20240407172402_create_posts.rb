class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :email
      t.string :title
      t.string :location
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :organiser
      t.date :deadline
      t.string :description
      t.string :url
      t.boolean :emailed
      t.string :tags, array: true, default: []
      t.boolean :recurring
      t.integer :recurring_interval_num
      t.string :recurring_interval_unit
      t.string :custom_recurring_info
      t.datetime :published_at
      t.boolean :published, default: false
      t.timestamps
    end
  end
end
