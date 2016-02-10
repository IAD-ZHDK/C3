class CommentNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(comment)
    ParticipantsService.new(comment.clinic).users.each do |user|
      unless user.id == comment.user_id
        NotificationMailer.comment_email(comment, user).deliver_later!
      end
    end
  end
end
