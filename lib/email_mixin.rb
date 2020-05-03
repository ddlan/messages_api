module EmailMixin

  def is_email_plausible?(email)
    URI::MailTo::EMAIL_REGEXP.match?(email)
  end
end