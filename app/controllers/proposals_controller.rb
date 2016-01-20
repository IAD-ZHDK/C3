class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(permitted_params[:proposal])
    if @proposal.save
      redirect_to overview_path
    else
      render 'new'
    end
  end

  def attend
    @proposal = Proposal.find(params[:id])
    @proposal.attendances.find_or_create_by(user_id: current_user.id)
    redirect_to overview_path
  end

  protected

  def permitted_params
    params.permit(proposal: [:title, :description])
  end
end
