class NotificationMailer < ActionMailer::Base
  default from: ENV['MAIL_SENDER']

  def adoption_notification(clinic, user)
    @clinic = clinic
    @user = user

    mail to: @user.email, subject: "#{@clinic.title} has been adopted"
  end

  def comment_notification(comment, user)
    @comment = comment
    @user = user

    mail to: @user.email, subject: "New comment by #{@comment.user.name}"
  end

  def scheduling_notification(clinic, user)
    @clinic = clinic
    @user = user

    mail to: @user.email, subject: "#{@clinic.title} has been scheduled"
  end
end
