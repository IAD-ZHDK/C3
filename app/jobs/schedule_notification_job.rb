class ScheduleNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(clinic)
    ParticipantsService.new(clinic).users.each do |user|
      unless user.id == clinic.proposer_id
        NotificationMailer.schedule_email(clinic, user).deliver_later!
      end
    end
  end
end
