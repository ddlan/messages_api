class TwilioVerificationCodeJob < ApplicationJob
  queue_as :default

  def perform(phone, body)
    TwilioClient.new.send_sms(phone.number, body)
  end
end