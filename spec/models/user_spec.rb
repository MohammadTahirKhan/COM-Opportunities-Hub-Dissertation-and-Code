# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(100)
#  encrypted_password     :string(100)
#  full_name              :string
#  last_sign_in_at        :datetime
#  notification_ids       :bigint           default([]), is an Array
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  saved_post_ids         :bigint           default([]), is an Array
#  tags                   :string           default([]), is an Array
#  uid                    :string
#  user_role              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
