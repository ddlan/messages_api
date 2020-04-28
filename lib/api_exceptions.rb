module ApiExceptions
  class BaseException < StandardError
    attr_reader :status, :message

    def initialize(status: nil, code: nil, message: nil)
      @status = status
      @message = message
    end
  end

  class ClientException < BaseException; end
  class ServerException < BaseException; end

  class PhoneNotPlausible < ClientException
    def initialize
      super(status: :unprocessable_entity, message: 'phone number is invalid')
    end
  end

end