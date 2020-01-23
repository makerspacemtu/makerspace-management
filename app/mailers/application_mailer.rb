class ApplicationMailer < ActionMailer::Base

  default from: 'thealleymanagement@gmail.com'

  def event_email(user)
    @events = Event.where('event_end >= ?', 1.week.ago)
    mail(to: user.email, subject: 'The Alley Weekly Events Summary')
  end

end
