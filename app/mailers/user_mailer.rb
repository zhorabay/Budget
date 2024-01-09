class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    @token = token
    @resource = record
    devise_mail(record, :confirmation_instructions, opts)
  end
end
