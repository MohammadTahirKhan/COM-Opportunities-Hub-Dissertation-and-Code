class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.date :date
      t.string :organiser
      t.date :deadline
      t.string :description
      t.string :url
      t.string :post_type
      t.boolean :emailed
      t.text :tags
      t.string :recurring

      t.timestamps
    end
  end
end
