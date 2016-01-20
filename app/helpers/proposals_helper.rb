module ProposalsHelper
  def votable?(request)
    !current_user.votes.where(request_id: request.id).any?
  end

  def attendable?(proposal)
    !current_user.attendances.where(proposal_id: proposal.id).any?
  end
end
