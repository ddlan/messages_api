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
#  index_phones_on_number   (number) UNIQUE
#  index_phones_on_user_id  (user_id)
#
class Phone < ApplicationRecord
  phony_normalize :number, default_country_code: 'US'
  validates :number, phony_plausible: true

  belongs_to :user, optional: true

  VERIFICATION_CODE_LENGTH = 6

  class << self
    def generate_verification_code
      SecureRandom.random_number(10**VERIFICATION_CODE_LENGTH).to_s.rjust(VERIFICATION_CODE_LENGTH, '0')
    end

    def send_twilio_verification_code(phone)
      TwilioVerificationCodeJob.perform_now(phone, "Your Opia verification code is: #{phone.verification_code}")
    end

    def create_or_update!(phone_number)
      phone = Phone.find_by(number: phone_number)
      verification_code = Phone.generate_verification_code
      verification_code_expires_at = 5.minutes.from_now

      if phone.present?
        phone.update!(
            verification_code: verification_code,
            verification_code_expires_at: verification_code_expires_at
        )
      else
        phone = Phone.create!(
            number:  phone_number,
            verification_code: verification_code,
            verification_code_expires_at: verification_code_expires_at
        )
      end
      phone
    end
  end

  def update_verification_code!
    verification_code = Phone.generate_verification_code
    verification_code_expires_at = 5.minutes.from_now

    update!(
        verification_code: verification_code,
        verification_code_expires_at: verification_code_expires_at
    )
  end
end
