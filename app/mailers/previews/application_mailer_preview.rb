class ApplicationMailerPreview < ActionMailer::Preview
  def application_mail_preview
    ApplicationMailer.application_email(@user).first)
  end
end
