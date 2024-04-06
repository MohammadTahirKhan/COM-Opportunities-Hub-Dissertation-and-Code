class ChangeTagsDataTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :posts, :tags, :string
    end
  
    def down
      change_column :posts, :tags, :text
    end
  end
end
