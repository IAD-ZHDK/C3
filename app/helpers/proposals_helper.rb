module ProposalsHelper
  def votable?(proposal)
    !current_user.votes.where(proposal_id: proposal.id).any?
  end
end
