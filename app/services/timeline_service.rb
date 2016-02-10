class TimelineService
  def initialize(clinic)
    @clinic = clinic
  end

  def fetch
    @votes = @clinic.votes.order_by(created_at: :asc)
    @attendances = @clinic.attendances.order_by(created_at: :asc)
    @comments = @clinic.comments.order_by(created_at: :asc)
  end

  def structure
    @events = []

    if @clinic.requested_at.present?
      @events.push({
        type: 'requested',
        time: @clinic.requested_at,
        name: @clinic.requester.name,
        text: "Requested by #{@clinic.requester.name}"
      })
    end

    if @clinic.proposed_at.present?
      @events.push({
        type: 'proposed',
        time: @clinic.proposed_at,
        name: @clinic.proposer.name,
        text: "Proposed by #{@clinic.requester.name}"
      })
    end

    @votes.each do |vote|
      @events.push({
        type: 'voted',
        time: vote.created_at,
        name: vote.user.name,
        text: "Voted by #{@clinic.requester.name}"
      })
    end

    if @clinic.scheduled_at.present?
      @events.push({
        type: 'scheduled',
        time: @clinic.scheduled_at,
        name: @clinic.proposer.name,
        text: "Scheduled by #{@clinic.requester.name}"
      })
    end

    @attendances.each do |attendance|
      @events.push({
        type: 'attended',
        time: attendance.created_at,
        name: attendance.user.name,
        text: "Confirmed by #{@clinic.requester.name}"
      })
    end

    if @clinic.conducted?
      @events.push({
        type: 'conducted',
        time: @clinic.appointment,
        name: @clinic.proposer.name,
        text: "Conducted by #{@clinic.requester.name}"
      })
    end

    @comments.each do |comment|
      @events.push({
        type: 'comment',
        time: comment.created_at,
        name: comment.user.name,
        text: "Commented by #{@clinic.requester.name}"
      })
    end
  end

  def to_hash
    fetch
    structure
    @events
  end
end
