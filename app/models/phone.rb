# == Schema Information
#
# Table name: phones
#
#  id                           :bigint           not null, primary key
#  number                       :string
#  verification_code            :string
#  verification_code_expires_at :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  user_id                      :bigint
#
# Indexes
#
#  index_phones_on_number   (number)
#  index_phones_on_user_id  (user_id)
#
class Phone < ApplicationRecord

  belongs_to :user

  VERIFICATION_CODE_LENGTH = 6

  class << self
    def generate_verification_code
      SecureRandom.random_number(10**VERIFICATION_CODE_LENGTH).to_s.rjust(VERIFICATION_CODE_LENGTH, '0')
    end
  end
end
