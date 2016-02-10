class ParticipantsService
  def initialize(clinic)
    @clinic = clinic
  end

  def voter_ids
    @clinic.votes.distinct(:user_id)
  end

  def attendee_ids
    @clinic.attendances.distinct(:user_id)
  end

  def commenter_ids
    @clinic.comments.distinct(:user_id)
  end

  def user_ids
    (voter_ids + attendee_ids + commenter_ids).uniq
  end

  def users
    User.find(user_ids)
  end
end
