class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, limit: 100
      t.string :encrypted_password, limit: 100
      t.string :full_name
      t.string :provider
      t.datetime :reset_password_sent_at
      t.string :reset_password_token
      t.string :uid
      t.string :user_role
      t.datetime :remember_created_at
      t.string :tags, array: true, default: []
      t.datetime :last_sign_in_at

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
