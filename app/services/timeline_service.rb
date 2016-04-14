class TimelineService
  def initialize(clinic)
    @clinic = clinic
  end

  def fetch
    @votes = @clinic.votes.order_by(created_at: :asc)
    @confirmations = @clinic.confirmations.order_by(created_at: :asc)
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
        text: "Proposed by #{@clinic.proposer.name}"
      })
    end

    @votes.each do |vote|
      @events.push({
        type: 'voted',
        time: vote.created_at,
        name: vote.user.name,
        text: "Voted by #{vote.user.name}"
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

    @confirmations.each do |confirmation|
      @events.push({
        type: 'confirmed',
        time: confirmation.created_at,
        name: confirmation.user.name,
        text: "Confirmed by #{confirmation.user.name}"
      })
    end

    if @clinic.conducted?
      @events.push({
        type: 'conducted',
        time: @clinic.appointment,
        name: @clinic.proposer.name,
        text: "Conducted by #{@clinic.proposer.name}"
      })
    end

    @comments.each do |comment|
      @events.push({
        type: 'comment',
        time: comment.created_at,
        name: comment.user.name,
        text: "Commented by #{comment.user.name}"
      })
    end
  end

  def to_hash
    fetch
    structure
    @events
  end
end
