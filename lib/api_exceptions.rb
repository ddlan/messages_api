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
  class UnauthorizedException < BaseException; end

  class MissingParameters < ClientException
    def initialize
      super(status: :unprocessable_entity, message: 'request parameters missing')
    end
  end

  class PhoneNotPlausible < ClientException
    def initialize
      super(status: :unprocessable_entity, message: 'phone number is invalid')
    end
  end

  class PhoneNotFound < ClientException
    def initialize
      super(status: :unprocessable_entity, message: 'phone number not found')
    end
  end

  class VerificationCodeInvalid < ClientException
    def initialize
      super(status: :unauthorized, message: 'verification code invalid')
    end
  end

  class VerificationCodeExpired < UnauthorizedException
    def initialize
      super(status: :unauthorized, message: 'verification code expired')
    end
  end

  class AuthorizationTokenInvalid < UnauthorizedException
    def initialize
      super(status: :unauthorized, message: 'authorization token invalid')
    end
  end

  class UserNotFound < UnauthorizedException
    def initialize
      super(status: :unauthorized, message: 'user not found')
    end
  end
end