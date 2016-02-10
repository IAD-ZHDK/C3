class NotificationMailer < ActionMailer::Base
  default from: ENV['MAIL_SENDER']

  def comment_email(comment, user)
    @comment = comment
    @user = user

    mail to: @user.email, subject: "New comment by #{@comment.user.name}"
  end
end
