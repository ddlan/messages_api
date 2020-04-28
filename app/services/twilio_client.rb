require 'twilio-ruby'

class TwilioClient
  # TODO(Elman): Make sure we set our account SID, AUTH token, and from number as environment Variable

  def initialize
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new @account_sid, @auth_token
  end

  def send_sms(to_number, body)
    begin
      @client.api.account.messages.create(
          from: ENV['TWILIO_FROM_NUMBER'],
          to: to_number,
          body: body
      )
    rescue Twilio::REST::TwilioError => e
      Rails.logger.warn("Twilio send_sms failed to #{to_number}, message #{e.message}")
    end
  end
end