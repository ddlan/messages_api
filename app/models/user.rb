# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  applozic_access_token   :string
#  email_address           :string
#  email_verification_code :string
#  first_name              :string
#  is_email_verified       :boolean
#  last_name               :string
#  phone_number            :string
#  status                  :integer          default(0)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  applozic_user_id        :string(150)
#
# Indexes
#
#  index_users_on_applozic_access_token  (applozic_access_token) UNIQUE
#  index_users_on_applozic_user_id       (applozic_user_id) UNIQUE
#  index_users_on_email_address          (email_address) UNIQUE
#  index_users_on_phone_number           (phone_number) UNIQUE
#
class User < ApplicationRecord
  phony_normalize :phone_number, default_country_code: 'US'
  has_one :Phone

  def find_by_phone_number(phone_number)

  end
end
