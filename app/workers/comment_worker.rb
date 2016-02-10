class CommentWorker
  include Sidekiq::Worker

  def perform(comment_id)
    comment = Comment.find(comment_id)
    ParticipantsService.new(comment.clinic).users.each do |user|
      unless user.id == comment.user_id
        NotificationMailer.comment_email(comment, user).deliver_later!
      end
    end
  end
end
