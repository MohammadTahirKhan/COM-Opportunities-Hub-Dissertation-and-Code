# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email                   :string(100)
#  encrypted_password      :string(100)
#  full_name               :string
#  last_sign_in_at         :datetime
#  provider                :string
#  read_notification_ids   :bigint           default([]), is an Array
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  saved_post_ids          :bigint           default([]), is an Array
#  tags                    :string           default([]), is an Array
#  uid                     :string
#  unread_notification_ids :bigint           default([]), is an Array
#  user_role               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
    # has_secure_password
    # validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }\
    
    devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable,
              :omniauthable, omniauth_providers: [:google_oauth2]

              # This method is used to create a new user from the omniauth hash
              # Omniauth with google will be fixed in the next sprint
              def self.from_omniauth(auth)
                where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
                  user.email = auth.info.email
                  user.password = Devise.friendly_token[0, 20]
                  user.full_name = auth.info.name
                end
              end
end
